from rest_framework import serializers
from .models import *

class  WaterLevelSerializer(serializers.ModelSerializer):
    class Meta:
        model =  WaterLevel
        fields = '__all__'
class  SoilMoistureSerializer(serializers.ModelSerializer):
    class Meta:
        model =  SoilMoisture
        fields = '__all__'
class  WateringPlantSerializer(serializers.ModelSerializer):
    class Meta:
        model =  WateringPlant
        fields = '__all__'

class  LEDPlantSerializer(serializers.ModelSerializer):
    class Meta:
        model =  LEDPlant
        fields = '__all__'        