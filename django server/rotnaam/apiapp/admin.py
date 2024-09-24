from django.contrib import admin
from .models import *

# admin.site.register(Profile)
# admin.site.register(ResetPasswordOTP)
# admin.site.register(Transaction)
# admin.site.register(Plant)
# admin.site.register(Question)
# admin.site.register(Answer)


class ProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'profile_img', 'phone_number', 'token', 'job')


class ResetPasswordOTPAdmin(admin.ModelAdmin):
    list_display = ('user', 'otp')


class TransactionAdmin(admin.ModelAdmin):
    list_display = ('user', 'amount', 'detail', 'transtype', 'date')


class PlantAdmin(admin.ModelAdmin):
    list_display = ('user', 'plant_img', 'plantname',
                    'detail', 'startdate', 'status', 'enddate')


class PostAdmin(admin.ModelAdmin):
    list_display = ('user', 'question', 'date')


class CommentAdmin(admin.ModelAdmin):
    list_display = ('user', 'name', 'question', 'answer', 'date')


class ArticleAdmin(admin.ModelAdmin):
    list_display = ('title', 'content', 'article_img')


admin.site.register(Profile, ProfileAdmin)
admin.site.register(ResetPasswordOTP)
admin.site.register(Transaction, TransactionAdmin)
admin.site.register(Plant, PlantAdmin)
admin.site.register(Post, PostAdmin)
admin.site.register(Comment, CommentAdmin)
admin.site.register(Article, ArticleAdmin)
