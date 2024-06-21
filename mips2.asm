init :		addi $2 , $0, 11 	#n , valeur nb incrément  
		addi $3 , $0, 1         #registre 
		addi $4 , $0 ,0
		
boucle:		beq $3 , $2, fin        #si n = compteur saut fin
		sw $3, 0x2000($4)       #ecrit en mémoire 
		addi $4 , $4 , 4        #incremente le registre
		addi $3, $3 , 1        	#incremente le compteur
				        		        		       
		j boucle 		#jump à boucle
fin:		
