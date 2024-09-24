from django.shortcuts import render
from django.http import HttpResponse
import uuid
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
####################################
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view

from .models import *
from .emailsystem import sendthai
from django.contrib.auth.models import User
import random
import re
from .serializers import *


@api_view(['POST'])
def rigister(request):
    if request.method == 'POST':
        print(request.body)
        print(type(request.data))
        data = request.data
        username = data.get('username')
        email = data.get('email')
        name = data.get('first_name')
        password = data.get('password')
        print('Check User ', username, password)
        # ตววจสอบว่ามี account ?
        if username == None and password == None:
            dt = {'status': 'username and password required'}
            return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)
        check = User.objects.filter(username=username)
        if len(check) == 0:
            newuser = User()
            newuser.username = username
            newuser.set_password(password)  # ฟังก์ชั่นการเข้ารหัส
            newuser.email = email
            newuser.first_name = name
            newuser.save()
            newprofile = Profile()
            newprofile.user = User.objects.get(username=username)
            gentoken = uuid.uuid1().hex
            newprofile.token = gentoken
            newprofile.save()
            dt = {'status': 'user_created',
                  'token': gentoken,
                  'email': username}
            return Response(data=dt, status=status.HTTP_201_CREATED)
        else:
            dt = {'status': 'user-exist'}
            return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def authenticate_app(request):
    if request.method == 'POST':
        data = request.data
        email = data.get('email')
        password = data.get('password')
        check = User.objects.filter(username=email)
        if len(check) == 0:
            dt = {'status': 'email-doesnot-exist'}
            print('failed', dt)
            return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)
        else:
            try:
                user = authenticate(username=email, password=password)
                login(request, user)
                getuser = User.objects.get(username=email)
                print(getuser.profile.user_id)
                profileImg = str(getuser.profile.profile_img)
                dt = {'status': 'login-success',
                      'token': getuser.profile.token,
                      'user': getuser.profile.user_id,
                      'first_name': getuser.first_name,
                      'profile_img': "/media/{}".format(profileImg)
                      }
                print('Success', dt)
                return Response(data=dt, status=status.HTTP_200_OK)
            except:
                getuser = User.objects.get(username=email)
                if password != getuser.password:
                    dt = {'status': 'password-wrong'}
                    print('failed', dt)
                    return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)

# ส่งเมล


@api_view(['POST'])
def resetpassword(request):
    if request.method == 'POST':
        data = request.data
        email = data.get('email')
        check = User.objects.filter(username=email)
        getuser = User.objects.get(username=email)
        if len(check) == 0:
            dt = {'status': 'email-doesnot-exist'}
            print('failed', dt)
            return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)
        else:
            user = User.objects.get(username=email)
            randomnum = random.randint(1000, 9999)
            otp = str(randomnum)
            newreset = ResetPasswordOTP()
            newreset.user = user
            newreset.otp = otp
            newreset.save()
            text = '''กรุณาใส่เลข OTP นี้ เพื่อรีเซ็ตรหัสผ่านของคุณ\n
                             █▀▀▀▀▀▀▀▀▀▀▀▀▀█
                             █░░        {}       ░░█
                             █▄▄▄▄▄▄▄▄▄▄▄▄▄█'''.format(otp)

            sendthai(email, 'Reset password OTP (ROTNAAM Notify)', text)
            dt = {'status': 'email-done',
                  'id': newreset.id}
            print('Success', dt)
            print('Success Send Email',)
            return Response(data=dt, status=status.HTTP_200_OK)

# ส่งotp


@api_view(['POST'])
def otppassword(request, ID):
    if request.method == 'POST':
        data = request.data
        otp = data.get('otp')
        check = ResetPasswordOTP.objects.filter(otp=otp, id=ID)
        if len(check) == 0:
            dt = {'status': 'otp-doesnot'}
            print('failed', dt)
            return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)
        else:
            dt = {'status': 'otp-success'}
            print('Success', dt)
            return Response(data=dt, status=status.HTTP_200_OK)

# ตั้งรหัสใหม่


@api_view(['POST'])
def resetnewpassword(request, ID):
    data = request.data
    newpassword = data.get('resetpassword')
    # print("FN :",data['resetpassword'])
    # print("token :", ID)
    if request.method == 'POST':
        check = ResetPasswordOTP.objects.get(id=ID)
    try:
        user = check.user
        # set_password เป็นการhashing เข้ารหัสทางเดียว sha256 การเข้ารหัสคริปโตกราฟฟี่
        user.set_password(newpassword)
        user.save()
        user = authenticate(username=user.username, password=newpassword)
        dt = {'status': 'password-changed'}
        return Response(data=dt, status=status.HTTP_200_OK)
    except:
        dt = {'status': 'password-error'}
        return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)


@api_view(['PATCH'])
def update_image_profile(request, UID):
    try:
        instance = Profile.objects.get(pk=UID)
    except Profile.DoesNotExist:
        return Response({'error': 'Object not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PATCH':
        serializer = ProfileSerializer(
            instance, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response({'error': 'Invalid request method'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)


@api_view(['GET'])
def get_profile_img(request, UID):
    try:
        check = Profile.objects.filter(user=UID)
        serializer = ProfileSerializer(check.last())

        getuser = User.objects.get(id=UID)
        dt = getuser.first_name
        print(dt)
        # serializer.append({'first_name': dt})
        print(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except:
        dt = {'status': 'otp-failed'}
        print('failed ไม่มี', dt)
        return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def post_transaction(request):
    if request.method == 'POST':
        serializer = TransactionSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

# GET Data


@api_view(['GET'])
def get_transaction(request, TID):
    try:
        check = Transaction.objects.filter(user=TID)
        serializer = TransactionSerializer(check, many=True)
        print(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except:
        dt = {'status': 'otp-failed'}
        print('failed ไม่มี', dt)
        return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)

# Update Data


@api_view(['PUT'])
def update_transaction(request, TID):
    transaction = Transaction.objects.get(id=TID)
    if request.method == 'PUT':
        data = {}
        serializer = TransactionSerializer(transaction, data=request.data)
        if serializer.is_valid():
            serializer.save()
            data['status'] = 'updated'
            return Response(data=data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

# DELATE Data


@api_view(['DELETE'])
def delete_transaction(request, TID):
    todo = Transaction.objects.get(id=TID)
    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data['status'] = 'deleted'
            statuscode = status.HTTP_200_OK
        else:
            data["status"] = 'failed'
            statuscode = status.HTTP_404_NOT_FOUND
        return Response(data=data, status=statuscode)


# # --------------------PLATN Managemant-----------------------------
@api_view(['POST'])
def post_plants(request):
    if request.method == 'POST':
        serializer = PlantsSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)


@api_view(['PATCH'])
def update_plant(request, PID):
    try:
        instance = Plant.objects.get(pk=PID)
    except Plant.DoesNotExist:
        return Response({'error': 'Object not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PATCH':
        serializer = PlantsSerializer(
            instance, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response({'error': 'Invalid request method'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)


@api_view(['GET'])
def get_plants(request, UID):
    try:
        check = Plant.objects.filter(user=UID)
        serializer = PlantsSerializer(check, many=True)
        print(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except:
        dt = {'status': 'otp-failed'}
        print('failed ไม่มี', dt)
        return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)

# Update Data


@api_view(['PATCH'])
def update_plant_img(request, PID):
    try:
        instance = Plant.objects.get(pk=PID)
    except Profile.DoesNotExist:
        return Response({'error': 'Object not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PATCH':
        serializer = PlantsSerializer(
            instance, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response({'error': 'Invalid request method'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)


@api_view(['PATCH'])
def petch_status_plant(request, PID):
    try:
        instance = Plant.objects.get(pk=PID)
    except Plant.DoesNotExist:
        return Response({'error': 'Object not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PATCH':
        serializer = PlantsSerializer(
            instance, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response({'error': 'Invalid request method'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)


@api_view(['GET'])
def get_img_plant(request, TID):
    try:
        check = Profile.objects.filter(user=TID)
        serializer = PlantsSerializer(check, many=True)
        getuser = User.objects.get(id=TID)
        dt = getuser.first_name
        print(dt)
        print(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except:
        dt = {'status': 'otp-failed'}
        print('failed ไม่มี', dt)
        return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def post_question(request):
    if request.method == 'POST':
        data = request.data
        user_id = data.get('user')
        question = data.get('question')
        date = data.get('date')
        getuser = User.objects.get(id=user_id)
        new = Post()
        new.user_id = user_id
        new.name = getuser.first_name
        new.profile_img = getuser.profile.profile_img
        new.date = date
        new.question = question
        new.save()
        # dt = {'id': new.id,
        #           'user_id': user_id,
        #           'question': question,'name': getuser.first_name,'date':date,'imageProfile':image_p}

        return Response(status=status.HTTP_201_CREATED)
    else:
        dt = {'status': 'faild'}
        return Response(data=dt, status=status.HTTP_404_NOT_FOUND)


@api_view(['GET'])
def get_question(request):
    try:
        all_question = Post.objects.all()
        serializer = PostSerializer(all_question, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except:
        dt = {'status': 'otp-failed'}
        print('failed ไม่มี', dt)
        return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def post_comment(request):
    if request.method == 'POST':
        data = request.data
        user_id = data.get('user')
        q_id = data.get('q_id')
        print(q_id)
        answer = data.get('answer')
        date = data.get('date')
        getuser = User.objects.get(id=user_id)
        new = Comment()
        new.user_id = user_id
        new.name = getuser.first_name
        new.profile_img = getuser.profile.profile_img
        new.question_id = q_id
        new.answer = answer
        new.date = date
        new.save()
        return Response(data=dt, status=status.HTTP_201_CREATED)
    else:
        dt = {'status': 'faild'}
        return Response(data=dt, status=status.HTTP_404_NOT_FOUND)


@api_view(['GET'])
def get_comment(request, ID):
    try:
        check = Comment.objects.filter(question=ID)
        serializer = CommentSerializer(check, many=True)
        print(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except:
        dt = {'status': 'otp-failed'}
        print('failed ไม่มี', dt)
        return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)


@api_view(['PATCH'])
def update_question(request, QID):
    try:
        instance = Post.objects.get(pk=QID)
    except Post.DoesNotExist:
        return Response({'error': 'Object not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PATCH':
        serializer = PostSerializer(instance, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response({'error': 'Invalid request method'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)


@api_view(['DELETE'])
def delete_question(request, QID):
    todo = Post.objects.get(id=QID)
    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data['status'] = 'deleted'
            statuscode = status.HTTP_200_OK
        else:
            data["status"] = 'failed'
            statuscode = status.HTTP_404_NOT_FOUND
        return Response(data=data, status=statuscode)


@api_view(['PATCH'])
def update_comment(request, AID):
    try:
        instance = Comment.objects.get(pk=AID)
    except Comment.DoesNotExist:
        return Response({'error': 'Object not found'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PATCH':
        serializer = CommentSerializer(
            instance, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    return Response({'error': 'Invalid request method'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)


@api_view(['DELETE'])
def delete_answer(request, AID):
    todo = Comment.objects.get(id=AID)
    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data['status'] = 'deleted'
            statuscode = status.HTTP_200_OK
        else:
            data["status"] = 'failed'
            statuscode = status.HTTP_404_NOT_FOUND
        return Response(data=data, status=statuscode)


@api_view(['GET'])
def get_question_only_user(request, UID):
    try:
        check = Post.objects.filter(user_id=UID)
        serializer = PostSerializer(check, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except:
        dt = {'status': 'failed'}
        return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def getArticle(request):
    try:
        all_article = Article.objects.all()
        new = Article(id=id)
        serializer = ArticleSerializer(all_article, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except:
        response = {'status': 'failed'}
        return Response(data=response, status=status.HTTP_400_BAD_REQUEST)
