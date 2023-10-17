from django.contrib import admin
from .models import *



# admin.site.register(SoilMoisture)
# admin.site.register(WaterLevel)
# admin.site.register(WaterPlant)
# admin.site.register(LEDPlant)


class SoilMoistureAdmin(admin.ModelAdmin):
    list_display= ('plant','soilmoisture','timestamp')

class WaterLevelAdmin(admin.ModelAdmin):
    list_display= ('plant','water_remaining','timestamp') 

class WaterPlantAdmin(admin.ModelAdmin): 
    list_display= ('plant','waterplant_time', 'status')
  
class LEDPlantAdmin(admin.ModelAdmin): 
    list_display= ('plant','led_time', 'status')


admin.site.register(SoilMoisture,SoilMoistureAdmin)
admin.site.register(WaterLevel,WaterLevelAdmin)
admin.site.register(WaterPlant,WaterPlantAdmin)
admin.site.register(LEDPlant,LEDPlantAdmin)