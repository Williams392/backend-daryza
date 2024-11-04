from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import *
from reports.reporte_productos import *
from reports.reporte_productos import DescargarPDFproductoView, DescargarExcelProductoView
from reports.dashboard import DashboardViewProductoSet 

router = DefaultRouter()
router.register(r'categorias', CategoriaViewSet)
router.register(r'marcas', MarcaViewSet)
router.register(r'unidadesmedida', UnidadMedidaViewSet)
router.register(r'dashboard', DashboardViewProductoSet, basename='dashboard-productos') 

urlpatterns = [
    path('', include(router.urls)),

    path('productos/', ProductoView.as_view(), name='producto-list'),  # Listar y crear productos
    path('productos/<int:pk_producto>/', ProductoView.as_view(), name='producto-detail'),  # Detalles, actualizar y eliminar un producto

    path('productos/descargar/pdf/', DescargarPDFproductoView.as_view(), name='producto-descargar-pdf'),
    path('productos/descargar/excel/', DescargarExcelProductoView.as_view(), name='producto-descargar-excel'),
] 
