# Generated by Django 4.2.4 on 2023-08-13 05:16

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('apiapp', '0015_remove_question_time_question_date'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='question',
            name='name',
        ),
    ]