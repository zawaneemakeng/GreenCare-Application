from django.shortcuts import render
from django.http import HttpResponse
import uuid
####################################
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Profile
import json
import uuid

from django.contrib.auth.models import User

@api_view(['POST'])
def rigister_newuser(request):
    if request.method == 'POST':
        print(request.body)
        print(type(request.data))
        datadict = request.data
        data = request.data
        print("FN :",datadict['first_name'])
        #data = request.POST.copy() ใช้กับเว็บ
        print(data)
        username = data.get('username')
        password = data.get('password')
        first_name = data.get('first_name')
        last_name = data.get('last_name')
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
            newuser.first_name = first_name
            newuser.last_name = last_name
            newuser.save()
            
            newprofile = Profile()
            newprofile.user = User.objects.get(username=username)
            newprofile.mobile = mobile

            gentoken = uuid.uuid1().hex
            newprofile.token = gentoken
            newprofile.save()
            dt = {'status': 'user_created',
                   'token':gentoken,
                   'first_name':first_name,
                   'last_name':last_name,
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
        username = data.get('username')
        password = data.get('password')
        try:
            user =  authenticate(username=username, password=password)
            login(request,user)
            getuser = User.objects.get(username=username)
            dt = {'status': 'login-success',
                   'token':getuser.profile.token,
                   'first_name':getuser.first_name,
                   'last_name':getuser.last_name,
                   'username':getuser.username}
            print('Success',dt)
            return Response(data=dt,status=status.HTTP_200_OK) 
        except:
            dt = {'status': 'login-failed'}
            print('failed',dt)
            return Response(data=dt,status=status.HTTP_400_BAD_REQUEST)