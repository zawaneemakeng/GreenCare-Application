from django.db import models


class Humid(models.Model):
    title = models.CharField(max_length=100)
    humidity = models.DecimalField(
        max_digits=5, decimal_places=2, null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)
