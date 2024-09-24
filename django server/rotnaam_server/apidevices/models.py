from django.db import models
from django.utils.timezone import now
from django.db import models
from apiapp.models import Plant


class SoilMoisture(models.Model):
    plant = models.ForeignKey(Plant, on_delete=models.CASCADE)
    soilmoisture = models.DecimalField(
        max_digits=5, null=True, default=0, decimal_places=1)
    timestamp = models.DateTimeField(default=now)

    def __str__(self):
        return self.plant.plantname+"\tของผู้ใช้\t"+self.plant.user.first_name


class WaterLevel(models.Model):
    plant = models.ForeignKey(Plant, on_delete=models.CASCADE)
    water_remaining = models.DecimalField(
        max_digits=5, null=True, default=0, decimal_places=1)
    timestamp = models.DateTimeField(default=now)

    def __str__(self):
        return self.plant.plantname+"\tของผู้ใช้\t"+self.plant.user.first_name


class WateringPlant(models.Model):
    plant = models.ForeignKey(Plant, on_delete=models.CASCADE)
    status = models.BooleanField(default=False)
    waterplant_time = models.DateTimeField(default=now)

    def __str__(self):
        return self.plant.plantname+"\tของผู้ใช้\t"+self.plant.user.first_name


class LEDPlant(models.Model):
    plant = models.ForeignKey(Plant, on_delete=models.CASCADE)
    status = models.BooleanField(default=False)
    led_time = models.DateTimeField(default=now)

    def __str__(self):
        return self.plant.plantname+"\tของผู้ใช้\t"+self.plant.user.first_name


class TimeC(models.Model):
    led_time = models.TimeField(default=now)

    def __str__(self):
        return self.led_time
