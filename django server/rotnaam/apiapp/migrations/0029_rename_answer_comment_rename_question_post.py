# Generated by Django 4.2.4 on 2023-10-21 06:09

from django.conf import settings
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('apiapp', '0028_alter_plant_enddate_alter_plant_startdate'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Answer',
            new_name='Comment',
        ),
        migrations.RenameModel(
            old_name='Question',
            new_name='Post',
        ),
    ]
