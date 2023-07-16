from django.contrib import admin
from .models import *

admin.site.register(Profile)
admin.site.register(ResetPasswordToken)
admin.site.register(Transaction)
admin.site.register(PlantManager)
admin.site.register(ImageManager)