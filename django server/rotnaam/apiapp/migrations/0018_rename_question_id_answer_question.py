# Generated by Django 4.2.4 on 2023-08-14 09:05

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('apiapp', '0017_question_name'),
    ]

    operations = [
        migrations.RenameField(
            model_name='answer',
            old_name='question_id',
            new_name='question',
        ),
    ]
