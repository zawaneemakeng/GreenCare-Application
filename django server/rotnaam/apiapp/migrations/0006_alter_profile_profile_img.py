# Generated by Django 4.2.4 on 2023-08-05 15:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apiapp', '0005_alter_profile_profile_img'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='profile_img',
            field=models.ImageField(blank=True, default='profile/default/user.png', null=True, upload_to='profile/'),
        ),
    ]
