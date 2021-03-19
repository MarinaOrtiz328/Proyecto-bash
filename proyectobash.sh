#!/bin/bash

parametro=$1

reinicio(){
    	echo -e "\n¿Regresar al menu anterior o terminar la ejecucion?: "
    	echo 1. Regresar al menú anterior
    	echo 2. Terminar ejecucion
    	read -p "Seleccione una opcion: " regresono
	if [ $regresono -eq 1 ] && [ $parametro = "-t" ]; then
		seleccionarB $n	
	elif [ $regresono -eq 1 ] && [ $parametro = "-a" ]; then
		seleccionarA $n
	else
		exit
	fi	
}

seleccionar(){
    echo "Usted esta en la sección $1, seleccione la opción que desea utilizar: "
    PS3="Ingrese opcion: " 
    select opt in agregar buscar eliminar leer_base_de_informacion ; do
    case $opt in
        agregar)
            read -p "Escribe el concepto nuevo: " nuevo_nombre
            read -p "Escribe su definición (sin saltos de linea): " nueva_definicion
            echo "[$nuevo_nombre] $nueva_definicion" >> "$1.inf"
	    echo "Agregado"
	    reinicio
        ;;
        buscar) 
            read -p "Inserte el concepto a buscar: " concepto
            if [ `grep "$concepto" -c "$1.inf"` -ge 1 ]; then
	    	echo "Encontrado"
		grep $concepto "$1.inf"
	    else   
            	echo "No encontrado"
		
	    fi
	    reinicio
        ;;
        eliminar)
            read -p "Escriba el concepto a eliminar: " concepto
           
	    if [ `grep "$concepto" -c "$1.inf"` -ge 1 ]; then
	    	n_linea=$(grep -n -m 1 $concepto $1.inf |sed  's/\([0-9]*\).*/\1/')
            

            	#código de eliminado:
            	ed -s $1.inf <<!
            	$n_linea d
            	w
!
            	#final 
            	echo "eliminado"
	    else
		    echo "Error al eliminar <Concepto no encontrado>."
	    fi
            reinicio 
            ;;

        leer_base_de_informacion)
          
	    if [ -s "$1.inf" ]; then
	        cat "$1.inf"
	    else
            echo -e "\nBase de informacion vacia"
	    fi
	    reinicio
            ;;
        *) 
            echo "Invalid option $REPLY";;
    esac
    done
}


seleccionarA(){
    case $1 in
        1)
            seleccionar SCRUM;;
        2)
            seleccionar X.P;;
        3)
            seleccionar Kanaban;;
        4)
            seleccionar Crystal;;
        *)
            echo "Parametro no valido, vuelva a ejecutar"
    esac
}

seleccionarB(){
    case $1 in
        1)
            seleccionar CASCADA;;
        2)
            seleccionar Espiral;;
        3)
            seleccionar ModeloV;;
        *)
            echo "Parametro no valido, vuelva a ejecutar"
    esac
}

#primer punto
menu(){
case $1 in
        -a)
        echo "Bienvenido a la guia rápida de Agile, para continuar seleccione un tema:"
        echo "1.SCRUM"
        echo "2. X.P"
        echo "3. Kanban"
        echo "4. Crystal"
        read -p "Selecciona una opcion: " n
        seleccionarA $n
                ;;
        -t)
        echo "Bienvenido a la guía rápida de metodologías tradicionales, para continuar seleccione un tema:"
        echo "1. Cascada"
        echo "2. Espiral"
        echo "3. Modelo V"
        read -p "Selecciona una opcion: " n
	seleccionarB $n
                ;;
        *)
        echo "Parametro no valido, vuelva a ejecutar"
        echo "Los parametros validos son: <-t> Agile, <-a> Metodologías tradicionales"
                ;;
esac

}

menu $parametro

