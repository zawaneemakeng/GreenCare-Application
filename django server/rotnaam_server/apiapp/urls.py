from django.urls import path
from .views import *
from django.contrib.staticfiles.urls import static, staticfiles_urlpatterns
from django.conf import settings

urlpatterns = [
    path('register', rigister),
    path('authenticate', authenticate_app),
    # path('api/profile/<int:TID>/',get_profile),
    path('update/profile/<int:UID>/', update_image_profile),
    path('media/profile/<int:UID>/', get_profile_img),
    # # reset password
    path('reset-password', resetpassword),
    path('otp-reset-password/<int:ID>', otppassword),
    path('reset-new-password/<int:ID>', resetnewpassword),

    # transection
    path('add-transaction', post_transaction),
    path('transection/<int:TID>/', get_transaction),
    path('api/update-transection/<int:TID>', update_transaction),
    path('api/delete-transection/<int:TID>', delete_transaction),
    # plant
    path('add-newplant', post_plants),
    path('get-plants/<int:UID>/', get_plants),
    path('update-plant/<int:PID>', update_plant),
    path('api/update-plant-img/<int:PID>', update_plant_img),
    path('petch/status-plant/<int:PID>/', petch_status_plant),
    path('media/plant/<int:TID>/', get_img_plant),

    path('post-question', post_question),
    path('get-question/', get_question),
    path('patch-question/<int:QID>', update_question),
    path('delete-question/<int:QID>', delete_question),

    path('post-answer', post_comment),
    path('get-answer/<int:ID>/', get_comment),
    path('patch-answer/<int:AID>', update_comment),
    path('delete-answer/<int:AID>', delete_answer),


    path('get-question-by/<int:UID>/', get_question_only_user),

    path('article/', getArticle),

]
# urlpatterns += staticfiles_urlpatterns
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
