from rest_framework import viewsets, permissions, filters
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from django_filters.rest_framework import DjangoFilterBackend
from categorias.api.serializers import CategoriaSerializer
from categorias import models

class CategoriaViewSet(viewsets.ModelViewSet):
    permission_classes = [permissions.IsAuthenticated]
    authentication_classes = (BasicAuthentication, SessionAuthentication, TokenAuthentication)
    serializer_class = CategoriaSerializer
    queryset = models.Categoria.objects.all()
    http_method_names = ['get', 'post']

    filter_backends = [
        DjangoFilterBackend, 
        filters.SearchFilter,
        filters.OrderingFilter 
    ]

    filterset_fields = ['nome']
    search_fields = ['nome']
    ordering_fields = ['nome']
    ordering = ['nome']