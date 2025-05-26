from rest_framework import serializers
from noticias import models

class NoticiaSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Noticia
        fields = '__all__'