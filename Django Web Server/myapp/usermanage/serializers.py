from rest_framework import serializers
from .models import *

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = '__all__'#'__all__' เอาทั้งหมดapi
        

class OTPSerializer(serializers.ModelSerializer):
    class Meta:
        model = ResetPasswordToken
        fields = '__all__'#'__all__' เอาทั้งหมดapi

class TransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transaction
        fields = ('id','user','amount','detail','transtype','date')


class PlantsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PlantManager
        fields = '__all__'

class QuestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = '__all__'


class AnswerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Answer
        fields = '__all__'

