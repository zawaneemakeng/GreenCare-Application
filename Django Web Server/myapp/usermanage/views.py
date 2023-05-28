from django.shortcuts import render,redirect
from django.http import HttpResponse
import uuid
####################################
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Profile,ResetPasswordToken
import json
import uuid
from .emailsystem import sendthai
from django.contrib.auth.models import User
import random

def Home(request):
    return HttpResponse('<h1>Hello</h1>')


@api_view(['POST'])
def rigister_newuser(request):
    if request.method == 'POST':
        print(request.body)
        print(type(request.data))
        datadict = request.data
        data = request.data
        # print("FN :",datadict['first_name'])
        #data = request.POST.copy() ใช้กับเว็บ
        print(data)
        username = data.get('username')
        email = data.get('email')
        password = data.get('password')
        mobile = data.get('mobile')
        print('Check User ',username,password)
        # ตววจสอบว่ามี account ?
        if username == None and password == None:
            dt ={'status':'username and password required'}
            return Response(data=dt,status=status.HTTP_400_BAD_REQUEST)


        check = User.objects.filter(username=username)
        if len(check) == 0:
            newuser = User()
            newuser.username = username
            newuser.set_password(password) #ฟังก์ชั่นการเข้ารหัส 
            newuser.email = email
            newuser.save()
            newprofile = Profile()
            newprofile.user = User.objects.get(username=username)
            newprofile.mobile = mobile

            gentoken = uuid.uuid1().hex
            newprofile.token = gentoken
            newprofile.save()
            dt = {'status': 'user_created',
                   'token':gentoken,
                   'username':username}
            return Response(data=dt,status=status.HTTP_201_CREATED)
        else :
            dt ={'status':'user-exist'}
            return Response(data=dt,status=status.HTTP_400_BAD_REQUEST)
        

from django.contrib.auth import authenticate,login
@api_view(['POST'])
def authenticate_app(request):
    if request.method == 'POST':
        data = request.data
        # email = data.get('email')
        username = data.get('username')
        password = data.get('password')
        
        try:

            user =  authenticate( username= username, password=password)
            login(request,user)
            getuser = User.objects.get( username= username)
            dt = {'status': 'login-success',
                   'token':getuser.profile.token,

                   'username':getuser.username}
            print('Success',dt)
            return Response(data=dt,status=status.HTTP_200_OK) 
        except:
            dt = {'status': 'login-failed'}
            print('failed',dt)
            return Response(data=dt,status=status.HTTP_400_BAD_REQUEST)
        

@api_view(['POST'])        
def resetPassword(request):
    if request.method == 'POST':
        data = request.data
        print(data)
        username = data.get('username')
        context = {}  # สิ่งที่จะเเนบไป
        try:
            user = User.objects.get(username=username)
            # number = random.randint(1000,9999)
           
            u = random.randint(1000,9999)
            token = str(u)
            newreset = ResetPasswordToken()
            newreset.user = user
            newreset.token = token
            newreset.save()
            text = '''กรุณากดลิงค์นี้ เพื่อรีเซ็ตรหัสผ่านของคุณ
                OTP : '''+token

            sendthai(username,'reset password link (Coffee shop', text)
            dt = {'status': 'login-success'}
            print('Success',dt)
            print('Success Send Email',)
            return Response(data=dt,status=status.HTTP_200_OK) 
        except: 
            dt = {'status': 'login-failed'}
            print('failed',dt)
            # context['message'] = 'อีเมล์ของคุณไม่มีในระบบ'
            return Response(data=dt,status=status.HTTP_400_BAD_REQUEST)
        
@api_view(['POST'])         
def ResetNewPassword(request):
    if request.method == 'POST':
        print(request.body)
        print(type(request.data))
        datadict = request.data
        data = request.data
        print("FN :",datadict['username'])
        print("FN :",datadict['token'])
        # email = data.get('email')
        username = data.get('username')
        token = data.get('token')        
        try:
            check = ResetPasswordToken.objects.filter(token=token)
            if len(check) !=0:
                dt = {'status': 'otp-success'}
                print('Success',dt)
                return Response(data=dt,status=status.HTTP_200_OK) 
        except:
            dt = {'status': 'otp-failed'}
            print('failed',dt)
            return Response(data=dt,status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])         
def ResetNewPassword2(request,token):
    context = {}
    datadict = request.data
    # data = request.data
    print("FN :",datadict['resetpassword1'])
    print("FN :",datadict['resetpassword1'])
    print("token :", token)
    try:
        check = ResetPasswordToken.objects.get(token=token)
        if request.method == 'POST':
            data = request.POST.copy()
            password = datadict['resetpassword1']
            password2 = datadict['resetpassword1']
            print(password)
            print(password2)
            if password == password2:
                user = check.user
                # set_password เป็นการhashing เข้ารหัสทางเดียว sha256 การเข้ารหัสคริปโตกราฟฟี่
                user.set_password(password2)
                user.save()
                user = authenticate(username=user.username, password=password2)
                context['error'] = 'ok'
                return Response(data=context,status=status.HTTP_200_OK) 
            else:
                context['error'] = 'not ok'
                return Response(data=context,status=status.HTTP_400_BAD_REQUEST)
    except:
        context['error'] = 'somtiong wrong'
        return Response(data=context,status=status.HTTP_400_BAD_REQUEST)