# Generated by Django 4.2.4 on 2023-10-21 12:57

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('apidevices', '0015_alter_soilmoisture_soilmoisture_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='TimeC',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('led_time', models.TimeField(default=django.utils.timezone.now)),
            ],
        ),
    ]