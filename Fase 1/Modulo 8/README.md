# AWS Infraestructura - Comparación de Costos

## Descripción
Este proyecto evalúa los costos asociados con el despliegue de una infraestructura en AWS en tres regiones distintas. Se incluye un desglose de costos estimados, configuración de recursos y recomendaciones para optimizar la infraestructura.

## Recursos Configurados

1. **Instancias EC2**:
   - 3 instancias t3.large por región.
   - Cada instancia tiene un volumen EBS de 500GB.
   - Snapshots diarios configurados para los volúmenes EBS.

2. **Almacenamiento S3**:
   - 1 bucket en clase de almacenamiento Standard.
   - 1 bucket en clase de almacenamiento Glacier.

3. **CloudFront**:
   - Una distribución con el bucket S3 Standard como origen.

4. **RDS**:
   - Una base de datos relacional db.t3.medium con 100GB de almacenamiento.

5. **DynamoDB**:
   - Tabla con 100 unidades de lectura y 100 de escritura aprovisionadas.

## Comparación de Costos
| Recurso           | Norte de Virginia | Irlanda        | Singapur       |
|-------------------|-------------------|----------------|----------------|
| **EC2 Instances** | $117.12          | $124.80        | $128.16        |
| **EBS Snapshots** | $75.00           | $80.00         | $85.00         |
| **S3 Standard**   | $23.00           | $25.00         | $27.00         |
| **S3 Glacier**    | $5.00            | $5.50          | $6.00          |
| **CloudFront**    | $85.00           | $90.00         | $95.00         |
| **RDS**           | $116.00          | $125.00        | $132.00        |
| **DynamoDB**      | $50.00           | $55.00         | $60.00         |
| **Total**         | $471.12          | $505.30        | $533.16        |

## Uso

1. **Terraform**:
   - Consulta los scripts en el directorio `main.tf` para implementar la infraestructura.

2. **AWS Pricing Calculator**:
   - Ajusta las configuraciones en la calculadora para reflejar tus necesidades específicas.

## Recomendaciones

- Utiliza la región **Norte de Virginia** para optimizar costos generales.
- Considera **Irlanda** o **Singapur** si la latencia para usuarios europeos o asiáticos es una prioridad.
- Revisa la configuración de DynamoDB para escalar dinámicamente según la demanda.
