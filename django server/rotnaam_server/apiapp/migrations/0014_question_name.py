# Generated by Django 4.2.4 on 2023-08-12 16:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apiapp', '0013_answer_question_id_alter_answer_answer'),
    ]

    operations = [
        migrations.AddField(
            model_name='question',
            name='name',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
    ]