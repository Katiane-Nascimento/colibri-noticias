from rest_framework import viewsets, permissions, filters
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from django_filters.rest_framework import DjangoFilterBackend
from noticias.api.serializers import NoticiaSerializer
from noticias import models

class NoticiaViewSet(viewsets.ModelViewSet):
    permission_classes = [permissions.IsAuthenticated]
    authentication_classes = (BasicAuthentication, SessionAuthentication, TokenAuthentication)
    serializer_class  = NoticiaSerializer
    queryset = models.Noticia.objects.all()
    http_method_names = ['get', 'post', 'put', 'delete']

    filter_backends = [
        DjangoFilterBackend, 
        filters.SearchFilter,
        filters.OrderingFilter 
    ]

    filterset_fields = ['categoria']
    search_fields = ['titulo', 'resumo', 'colaborador']
    ordering_fields = ['dataHoraAdicao']
    ordering = ['dataHoraAdicao']