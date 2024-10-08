# Generated by Django 4.2.4 on 2023-10-21 09:42

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apidevices', '0014_wateringplant_delete_waterplant'),
    ]

    operations = [
        migrations.AlterField(
            model_name='soilmoisture',
            name='soilmoisture',
            field=models.DecimalField(blank=True, decimal_places=1, max_digits=5, null=True),
        ),
        migrations.AlterField(
            model_name='waterlevel',
            name='water_remaining',
            field=models.DecimalField(blank=True, decimal_places=1, max_digits=5, null=True),
        ),
    ]
