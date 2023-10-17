from django.db import models
from django.utils.timezone import now
from django.db import models
from apiapp.models import Plant


class SoilMoisture(models.Model):
    plant = models.ForeignKey(Plant,on_delete=models.CASCADE)
    soilmoisture = models.DecimalField(max_digits=5,null=True,blank=True,decimal_places=2)
    timestamp =  models.DateTimeField(default=now)

    def __str__(self):
        return self.plant.plantname+"\tของผู้ใช้\t"+self.plant.user.first_name
    
class WaterLevel(models.Model):
    plant = models.ForeignKey(Plant,on_delete=models.CASCADE)
    water_remaining = models.DecimalField(max_digits=5,null=True,blank=True,decimal_places=2)
    timestamp =  models.DateTimeField(default=now)

    def __str__(self):
        return self.plant.plantname+"\tของผู้ใช้\t"+self.plant.user.first_name

class WaterPlant(models.Model):
    plant = models.ForeignKey(Plant,on_delete=models.CASCADE)
    status = models.CharField(max_length=50,default='ปิด')
    waterplant_time = models.DateTimeField(default=now)
    
    def __str__(self):
        return self.plant.plantname+"\tของผู้ใช้\t"+self.plant.user.first_name
    
class LEDPlant(models.Model):
    plant = models.ForeignKey(Plant,on_delete=models.CASCADE)
    status = models.CharField(max_length=50,default='ปิด')
    led_time = models.DateTimeField(default=now)
    
    def __str__(self):
        return self.plant.plantname+"\tของผู้ใช้\t"+self.plant.user.first_name