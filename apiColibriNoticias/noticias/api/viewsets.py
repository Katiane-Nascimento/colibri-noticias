from rest_framework import viewsets, permissions, filters
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.decorators import action
from rest_framework.response import Response
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

    filterset_fields = ['categoria', 'colaborador']
    search_fields = ['titulo', 'resumo', 'colaborador']
    ordering_fields = ['dataHoraAdicao']
    ordering = ['dataHoraAdicao']

    @action(detail=False, methods=['get'], url_path='count')
    def count(self, request):
        count = self.filter_queryset(self.get_queryset()).count()  # Respeita filtros aplicados na URL
        return Response({'count': count})