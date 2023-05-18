from django.db import models
from django.contrib.auth.models import User

class Profile(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE) #user.profile.token
    usertype = models.CharField(max_length=200,default='member')
    mobile = models.CharField(max_length=20,null=True, blank=True) #ไม่บังตับใส่
    token = models.CharField(max_length=100,default='-')
    verified = models.BooleanField(default=False)

    def __str__(self):
        return self.user.username
