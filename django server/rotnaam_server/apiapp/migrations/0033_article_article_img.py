# Generated by Django 4.2.4 on 2023-10-21 07:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apiapp', '0032_remove_article_detail_article_content_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='article',
            name='article_img',
            field=models.ImageField(blank=True, null=True, upload_to='article/'),
        ),
    ]