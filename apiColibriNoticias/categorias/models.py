from django.db import models

# Create your models here.
class Categoria(models.Model):
    nome = models.CharField(primary_key=True, max_length=100, blank=False, null=False)

    def __str__(self):
        return self.nome