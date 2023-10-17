from rest_framework import serializers
from .models import *

class  SoilMoistureSerializer(serializers.ModelSerializer):
    class Meta:
        model =  SoilMoisture
        fields = '__all__'

class  WaterLevelSerializer(serializers.ModelSerializer):
    class Meta:
        model =  WaterLevel
        fields = '__all__'

class  WaterPlantSerializer(serializers.ModelSerializer):
    class Meta:
        model =  WaterPlant
        fields = '__all__'

class  LEDPlantSerializer(serializers.ModelSerializer):
    class Meta:
        model =  LEDPlant
        fields = '__all__'        