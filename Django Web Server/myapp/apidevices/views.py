from django.shortcuts import render

# Create your views here.
from django.shortcuts import render
from django.http import HttpResponse

from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import *
import json
from .serializers import *


@api_view(['GET'])
def get_soilmoisture(request,PID):
    try:
            check_soil = SoilMoisture.objects.filter(plant_id=PID)
            serializer = SoilMoistureSerializer(check_soil,many=True)
            print(serializer.data)
            return Response(serializer.data,status=status.HTTP_200_OK)
    except:
            dt = {'status': 'otp-failed'}
            print('failed ไม่มี',dt)
            return Response(data=dt,status=status.HTTP_400_BAD_REQUEST)
     
@api_view(['POST'])
def post_soilmoisture(requset):
    print("POST DATA From ESP32")
    if requset.method =='POST':
        ser = SoilMoistureSerializer(data = requset.data)
        if ser.is_valid():
            ser.save()
            return Response(ser.data,status=status.HTTP_201_CREATED)
        return Response(ser.errors,status=status.HTTP_400_BAD_REQUEST)
    



@api_view(['POST'])
def post_waterlevel(requset):
    print("POST DATA From ESP32")
    if requset.method =='POST':
    
        ser = WaterLevelSerializer(data = requset.data)
        if ser.is_valid():
            ser.save()
            return Response(ser.data,status=status.HTTP_201_CREATED)
        return Response(ser.errors,status=status.HTTP_400_BAD_REQUEST)
    
@api_view(['GET'])
def get_waterlevel(request,PID):
    try:
            check_water = WaterLevel.objects.filter(plant_id=PID)
            serializer = WaterLevelSerializer(check_water,many=True)
            print(serializer.data)
            return Response(serializer.data,status=status.HTTP_200_OK)
    except:
            dt = {'status': 'otp-failed'}
            print('failed ไม่มี',dt)
            return Response(data=dt,status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def post_waterplant(requset):
    print("POST DATA From ESP32")
    if requset.method =='POST':
        ser = WaterPlantSerializer(data = requset.data)
        if ser.is_valid():
            ser.save()
            return Response(ser.data,status=status.HTTP_201_CREATED)
        return Response(ser.errors,status=status.HTTP_400_BAD_REQUEST)
    
@api_view(['POST'])
def post_ledplant(requset):
    print("POST DATA From ESP32")
    if requset.method =='POST':
        ser = LEDPlantSerializer(data = requset.data)
        if ser.is_valid():
            ser.save()
            return Response(ser.data,status=status.HTTP_201_CREATED)
        return Response(ser.errors,status=status.HTTP_400_BAD_REQUEST)
    
@api_view(['GET'])
def get_ledplant(request):
     try:
            all_question = LEDPlant.objects.all()
            serializer = LEDPlantSerializer(all_question,many=True)
            return Response(serializer.data,status=status.HTTP_200_OK)
     except:
            dt = {'status': 'otp-failed'}
            print('failed ไม่มี',dt)
            return Response(data=dt,status=status.HTTP_400_BAD_REQUEST)