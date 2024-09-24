from rest_framework import serializers
from .models import *

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = '__all__'#'__all__' เอาทั้งหมดapi
        

class OTPSerializer(serializers.ModelSerializer):
    class Meta:
        model = ResetPasswordOTP
        fields = '__all__'#'__all__' เอาทั้งหมดapi

class TransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transaction
        fields = ('id','user','amount','detail','transtype','date')


class PlantsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plant
        fields = '__all__'

class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = '__all__'


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'

class ArticleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Article
        fields = '__all__'