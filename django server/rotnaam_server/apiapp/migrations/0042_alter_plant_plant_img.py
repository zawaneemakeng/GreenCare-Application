# Generated by Django 4.2.1 on 2023-11-14 05:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apiapp', '0041_rename_birthdate_profile_job'),
    ]

    operations = [
        migrations.AlterField(
            model_name='plant',
            name='plant_img',
            field=models.ImageField(blank=True, default='plant/default/plant.png', null=True, upload_to='plant/'),
        ),
    ]