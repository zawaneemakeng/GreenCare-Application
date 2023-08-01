from django.shortcuts import render,redirect
from django.http import HttpResponse

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


