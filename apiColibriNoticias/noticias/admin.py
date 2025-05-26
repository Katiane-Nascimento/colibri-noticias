from django.contrib import admin
from .models import Noticia


@admin.register(Noticia)
class NoticiaAdmin(admin.ModelAdmin):
    list_display = ['titulo', 'resumo', 'colaborador', 'dataHoraPublicacao', 'dataHoraAdicao', 'categoria']
    search_fields = ['titulo', 'resumo']
    list_filter = ['categoria', 'colaborador']
