# Generated by Django 4.2.4 on 2023-08-26 03:21

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('apidevices', '0008_rename_time_waterplant_waterplant_time'),
    ]

    operations = [
        migrations.AlterField(
            model_name='waterplant',
            name='waterplant_time',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
    ]