# Generated by Django 4.2.4 on 2023-08-08 10:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apiapp', '0010_plantmanager_plant_img'),
    ]

    operations = [
        migrations.AlterField(
            model_name='resetpasswordtoken',
            name='otp',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]