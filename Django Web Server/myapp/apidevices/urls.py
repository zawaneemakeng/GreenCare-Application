from django.urls import path
from .views import *


urlpatterns = [
    path('api/post-soilmoisture',post_soilmoisture),
    path('api/get-soilmoisture/<int:PID>/',get_soilmoisture),
    path('api/post-waterlevel', post_waterlevel),
    path('api/get-waterlevel/<int:PID>/', get_waterlevel),
    path('api/post-waterplant', post_waterplant),
    path('api/post-ledplant', post_ledplant),
    path('api/get-ledplant/', post_ledplant),
    ]