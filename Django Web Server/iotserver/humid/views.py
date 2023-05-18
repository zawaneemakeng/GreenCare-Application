from django.shortcuts import render
from django.http import HttpResponse
####################################
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
import json
####################################


def Home(request):
    return HttpResponse('<h1>HELLO WORLD</h1>')


def Table(request):
    return HttpResponse('<h1>HELLO dfgfdlk</h1>')


def api_post_humid(request):
    print('Post Data ')
