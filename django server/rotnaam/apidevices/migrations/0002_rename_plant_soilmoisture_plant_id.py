# Generated by Django 4.2.4 on 2023-08-20 14:17

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('apidevices', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='soilmoisture',
            old_name='plant',
            new_name='plant_id',
        ),
    ]
