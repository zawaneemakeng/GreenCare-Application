# Generated by Django 4.2.4 on 2023-10-21 06:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apiapp', '0029_rename_answer_comment_rename_question_post'),
    ]

    operations = [
        migrations.CreateModel(
            name='Article',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(blank=True, max_length=100)),
                ('detail', models.CharField(blank=True, max_length=100)),
            ],
        ),
    ]
