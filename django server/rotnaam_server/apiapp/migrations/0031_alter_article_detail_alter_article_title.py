# Generated by Django 4.2.4 on 2023-10-21 06:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apiapp', '0030_article'),
    ]

    operations = [
        migrations.AlterField(
            model_name='article',
            name='detail',
            field=models.CharField(blank=True, max_length=1000),
        ),
        migrations.AlterField(
            model_name='article',
            name='title',
            field=models.CharField(blank=True, max_length=500),
        ),
    ]