from django.db import models
from categorias.models import Categoria
from uuid import uuid4

class Noticia(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid4,editable=False)
    imagem = models.URLField(blank=False, null=False)
    fonte = models.CharField(max_length=100, blank=False, null=False)
    titulo = models.CharField(max_length=200)
    resumo = models.CharField(max_length=200)
    link = models.URLField(blank=False, null=False)
    dataHoraPublicacao = models.DateTimeField(blank=False, null=False)
    dataHoraAdicao = models.DateTimeField(auto_now=True)
    colaborador = models.CharField(max_length=200)
    categoria = models.ForeignKey(Categoria, on_delete=models.SET_NULL, null=True, blank=True, related_name='noticias')

    def __str__(self):
        return self.titulo
    