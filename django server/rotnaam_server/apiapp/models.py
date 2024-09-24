from django.db import models
from django.contrib.auth.models import User


class Profile(models.Model):
    user = models.OneToOneField(
        User, on_delete=models.CASCADE)  # user.profile.token
    phone_number = models.CharField(
        max_length=20, default='ยังไม่กำหนด')  # ไม่บังตับใส่
    token = models.CharField(max_length=100, default='-')
    job = models.CharField(max_length=100, default='ยังไม่กำหนด')
    profile_img = models.ImageField(
        upload_to='profile/', null=True, blank=True, default='profile/default/user.png')

    def __str__(self):
        return self.user.first_name


class ResetPasswordOTP(models.Model):
    # ดึงอีกโมเดล   ondelete=models.CASCADE =ถ้าuserถูกลบ จะลบด้วย
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    otp = models.IntegerField(null=True, blank=True)

    def __str__(self):
        return self.user.username


class Plant(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    plantname = models.CharField(max_length=100, default=('-'))
    detail = models.CharField(max_length=100, default=('-'))
    startdate = models.CharField(
        max_length=100, default=('-'), null=True, blank=True)
    enddate = models.CharField(
        max_length=100, default=('-'), null=True, blank=True)
    plant_img = models.ImageField(
        upload_to='plant/', null=True, blank=True, default='plant/default/plant.jpg')
    status = models.BooleanField(default=False, null=True)
    setmoisture = models.DecimalField(
        max_digits=3, null=True, default=0, decimal_places=1)
    setstarttime = models.CharField(
        max_length=100, default=('-'), null=True, blank=True)
    setendtime = models.CharField(
        max_length=100, default=('-'), null=True, blank=True)

    def __str__(self):
        return self.plantname
    # +"\tของผู้ใช้\t"+self.user.username


class Transaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=8, decimal_places=1)
    detail = models.CharField(max_length=100, default=('-'))
    transtype = models.CharField(max_length=50)
    date = models.CharField(max_length=100, default=('-'))

    def __str__(self):
        return self.user.username


class Post(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100, blank=True, null=True)
    profile_img = models.ImageField(
        upload_to='profile/', null=True, blank=True, default='profile/default/user.png')
    question = models.CharField(max_length=400)
    date = models.CharField(
        max_length=100, default=('-'), null=True, blank=True)

    def __str__(self):
        return self.user.first_name


class Comment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    question = models.ForeignKey(Post, on_delete=models.CASCADE, null=True)
    name = models.CharField(max_length=100)
    profile_img = models.ImageField(
        upload_to='profile/', null=True, blank=True, default='profile/default/user.png')
    answer = models.CharField(max_length=400, null=True, blank=True)
    date = models.CharField(
        max_length=100, default=('-'), null=True, blank=True)

    def __str__(self):
        return self.name


class Article(models.Model):
    title = models.CharField(max_length=150, blank=True)
    content = models.TextField(blank=True)
    article_img = models.ImageField(
        upload_to='article/', null=True, blank=True,default=('-'))

    def __str__(self):
        return self.title
