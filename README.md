# sql-design-mysql

## Introducción 
Este repositorio tiene el objetivo de guardar el proyecto que he realizado para la asignatura Bases de datos SQL del Master de Big Data y Business Analytics de la Universidad Complutense de Madrid.

En este proyecto hemos trabajado con el entorno MySQLWorkbench : 

[MySQL Workench](https://www.mysql.com/products/workbench)

Y además con el lenguaje de programación MySQL:
[MySQL](https://www.mysql.com)


## Definiciones

**Bases de datos**
Una base de datos es un conjunto de datos pertenecientes a un mismo contexto y almacenados sistemáticamente para su posterior uso.
Se pueden identificar dos tipos de usos: como elemento integrador y una aplicación única.
Por ejemplo, una empresa puede utilizar una misma base de datos para todos los departamentos.

**Sistemas de Gestión de Bases de Datos**
El objetivo principal de un Sistema de Gestión de Bases de Datos(SGBD) es proporcionar una forma de almacenar y
recuperar la información de una Base de Datos, de manera que sea tanto práctica como eficiente.

Los Sistemas de Bases de Datos se diseñan para gestionar grandes cantidades de información, la gestión de los datos implica tanto la definición de estructuras para almacenar la información como los mecanismos para la manipulación de la
información. Estos sistemas deben garantizar la fiabilidad de la información almacenada, a pesar de las caídas del sistema o
de los intentos de acceso no autorizados.

**MySQL**
MySQL es el sistema de gestión de bases de datos relacional más extendido en la actualidad al estar basada en código abierto. Desarrollado originalmente por MySQL AB, fue adquirida por Sun MicroSystems en 2008 y esta su vez comprada por Oracle Corporation en 2010, la cual ya era dueña de un motor propio InnoDB para MySQL.

MySQL es un sistema de gestión de bases de datos que cuenta con una doble licencia. Por una parte es de código abierto, pero por otra, cuenta con una versión comercial gestionada por la compañía Oracle.

**Modelo Entidad-Relación**
Este modelo ofrece una manera de representar las entidades en la Base de Datos y el modo
en el que se relacionan entre si. El diseño de las Bases de Datos se expresará en términos del
diseño de Bases de Datos relacionales y del conjunto de restricciones asociado. Se mostrará
la manera en que el diseño E-R puede transformarse en un conjunto de esquemas de relación
y el modo en el que pueden incluir algunas de las restricciones en ese diseño.

Está compuesto por:
    -**Entidades** cosa u objeto en el mundo real que es distinguible de todos los demás
    objetos .
    - **Atributos**:Describen las propiedades que posee cada
    miembro de un conjunto de entidades.
    - **Clave primaria** de una entidad: conjunto mínimo de uno o más atributos
    cuyos valores determinan cada instancia de forma única.
    - ** Relación** es la asociación entre diferentes entidades. En las relaciones es muy importante diferenciar el tipo de cardinalidad que hay entre dos entidades. Pueden ser uno a uno, uno a varios o muchos a muchos.

**Reducción de un esquema E-R a tablas**
Los modelos E-R y el modelo relacional son representaciones abstractas y lógicas del
desarrollo del mundo real.
Una relación se puede considerar como una tabla de valores y una  entidad se representa mediante una tabla E con n columnas distintas, cada una de
las cuales corresponde a un atributo.
Cada fila de la tabla corresponde a una entidad del conjunto de entidades.

**Modelo relacional**
El modelo de datos relacional organiza y representa la información en forma de
tablas o relaciones, para representar tanto los datos como las relaciones entre
ellos. Su simplicidad conceptual ha conducido a su adopción generalizada.
Una base de datos relacional es un conjunto de tablas, a cada una de las
cuales se le asigna un nombre exclusivo.
- Cada fila de la tabla representa una colección de valores de datos relacionados
entre sí, se le denomina tupla. Esos valores se pueden interpretar como hechos
que describen una entidad o un vínculo entre entidades del mundo real.
- Todos los valores de una columna tienen el mismo tipo de datos

## El enunciado del problema

El móvil se ha convertido en algo no sólo cotidiano, sino necesario para la mayoría de las
actividades que realizamos cada día, bien sean sociales o personales. Se ha convertido en el
centro de nuestra vida, imprescindible en el ámbito profesional o de ocio. Las empresas de
tecnología han descubierto ahí un mercado, por eso han proliferado las empresas de creación
de aplicaciones para móviles y las tiendas de aplicaciones (app stores). El modelo de negocio
de las tiendas de aplicaciones se basa en una comisión, por lo general del 30%, sobre apps
descargadas y las ventas que se realicen desde las mismas. Si tenemos en cuenta que estamos
ante un mercado de millones de apps cuya única manera de descarga es a través de las tiendas
de aplicaciones, no cabe duda de que las tiendas de aplicaciones son una de las mayores y
más robustas fuentes de ingresos del ecosistema móvil. Las aplicaciones las realizan empresas
de servicios, cada aplicación es subida a las plataformas o tiendas de aplicaciones para ser
descargadas por los usuarios de móviles, cada aplicación puede tener o no un coste.
Vamos a crear una base de datos donde guardar la información de las tiendas de aplicaciones:
Apple (App Store), Google Android (Google Play Store), BlackBerry (App World),
WindowsPhone (MarketPlace), Nokia (OVITienda), HP (AppCatalog),
Amazon (Appstore), ... De la tienda sabemos el nombre, que es distinto para cada tienda,
quien la gestiona (Android, Apple, Amazon, ….) y dirección web.
De las empresas de servicios que realizan las aplicaciones (apps), conocemos su nombre, país
en el que paga sus impuestos, año de creación, correo electrónico y pagina web, sabemos que
estas empresas no tienen ninguna conexión con las tiendas de aplicaciones.
En la empresa hay empleados, pero debido al dinamismo en estos tipos de trabajo y, a la
oferta y la demanda en el sector, el empleado puede haber trabajado en varias empresas del
sector e incluso puede trabajar en la misma empresa en distintos periodos de tiempo, nos
interesa conocer la experiencia profesional del empleado. Además, del empleado nos interesa
el DNI, dirección (calle, número, código postal), correo electrónico y teléfonos.
De las aplicaciones, conocemos su nombre que es único, el código de aplicación distinto para
cada aplicación, la fecha en la que se comenzó a realizar, la fecha de terminación, la categoría
o categorías en las que se puede incluir (entretenimiento, social, educación, ...) porque una
aplicación puede tener varias categorías y por supuesto una categoría puede ser de varias
aplicaciones, además queremos saber el espacio de memoria que ocupa y el precio.
Las aplicaciones son subidas a las tiendas o plataformas. Una misma aplicación puede ser
subida a varias tiendas, por supuesto una tienda tiene muchas aplicaciones. Cada aplicación
está realizada por empleados, es dirigida por uno de ellos y un empleado puede dirigir varias
aplicaciones.
Un usuario puede descargar o no aplicaciones, pero no puede descargar dos veces la misma
aplicación, tendría que desistalarla y volverla a instalar. El usuario puede puntuar de 0 a 5
cada una de las aplicaciones que se descarga y hacer comentarios referentes a la misma. Del usuario conocemos el número de cuenta que es único, nombre, dirección y si se descarga la
aplicación en el teléfono conocemos el número de móvil.
Entre otras informaciones, nos interesa saber la fecha en la que se realizan más descargas, el
país de los usuarios que más aplicaciones se han descargado y la puntuación media de cada
una de las apps.

## Objetivos a cumplir
1. Diseño del modelo conceptual es decir, el modelo de Entidad-Relación del problema.
2. Diseño lógico como la definición del modelo relacional con el paso a tablas del modelo E-R.
3. Implementación del modelo en SQL.

## Apuntes
- Los datos de la Base de Datos son random. Tanto los datos pertenecientes a entidades como a relaciones se han guardado en la  carpeta llamada  . Los archivos son de csv ylos he importado a través de la opción Table Data Import Wizard.

- Se han generado la gran mayoría de los datos a través de la siguiente página:
    [Mockaroo](https://www.mockaroo.com/)

