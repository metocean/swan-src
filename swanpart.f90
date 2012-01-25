	program swanpart      

	use specpart
      
	integer mdc,msc,npart
	real,allocatable::spcdir(:),spcsig(:),spec(:,:),zp(:)
	integer,allocatable::imi(:),imo(:),buff(:),ind(:),ipart(:,:)
	character :: inpfil*100,filenm*100,hedlin*100
	integer ierr,nref,ifre,iang,nbounc,ibounc,ndsd,num
	real freqhz,dirdeg
	logical ccoord

	parameter(pi=4.*atan(1.0),dfac=2. * PI**2 / 180.)

	ihmax=200
	ndsd=10
	nref=6

	write(0,*),'SWAN spectral partition'
	nfin=iargc()
	write(0,*),nfin,' input files>'

	if (nfin.le.0) then                                           
		write(0,*),'No input file specified'
		write(0,*),'Use: specpart <swanspecfiles>'
		stop
	endif

	do ifile=1,nfin
	call getarg(ifile,inpfil)
	write(0,*),'Start of file: ',trim(inpfil)
	num=0
	open(unit=ndsd,file=inpfil,iostat=ierr,status='old',form='formatted')

10      read (ndsd, '(a)') hedlin
	write(nref,'(A)') trim(hedlin)	
!       skip heading lines starting with comment sign ($ as in command file)
        if (hedlin(1:1).eq.'$' .or. hedlin(1:1).eq.'!' .or. hedlin(1:4).eq.'SWAN') goto 10         
        if (hedlin(1:4).eq.'TIME') then                                   
          read (ndsd, *) ioptt
	  write(nref,*) ioptt
	else
	  ioptt=0
	endif
        read (ndsd, '(a)') hedlin
	write(nref,'(A)') trim(hedlin)	
        if (hedlin(1:3).eq.'LOC'.or.hedlin(1:3).eq.'LON') then                                    
          ccoord = .true.
        else
!         set ccoord to false to indicate that no locations are defined   
          ccoord = .false.                                                
        endif
        if (ccoord) then
          read (ndsd, *) nbounc
          write(nref,*) nbounc
          do ibounc = 1, nbounc
	    read (ndsd, '(a)') hedlin
	    write(nref,'(A)') trim(hedlin)		
	  enddo
	  read (ndsd, '(a)') hedlin
	  write(nref,'(A)') trim(hedlin)		
	endif
        if (hedlin(2:5).eq.'FREQ') then                              
          read (ndsd, *) msc
	  write(nref,*) msc
          allocate(spcsig(msc))                                   
          do ifre = 1, msc
!           read frequency in hz and convert to radians/sec
            read (ndsd, *) freqhz
	    write(nref,*) freqhz
            spcsig(ifre) = pi2 * freqhz                            
          enddo
	  read (ndsd, '(a)') hedlin
	  write(nref,'(A)') trim(hedlin)		
        endif
        if (hedlin(2:4).eq.'DIR') then                               
          read (ndsd, *) mdc
	  write(nref,*) mdc
	   allocate(spcdir(mdc))          
          do iang = 1, mdc
!           read direction in degr and convert to radians
            read (ndsd, *) dirdeg
	    write(nref,*) dirdeg
          enddo
	  read (ndsd, '(a)') hedlin
	  write(nref,'(A)') trim(hedlin)		
	endif
        if (hedlin(1:5).eq.'QUANT') then
          read (ndsd, *) nquant
	  write(nref,*) nquant
	endif
	do i=1,3
	  read (ndsd, '(a)') hedlin
	enddo
	write(nref,'(A)') 'Partitions'
	write(nref,'(A)') 'NonDim'
	write(nref,*) -9

	nspec=msc*mdc
	nk=msc
	nth=mdc

	allocate(spec(msc,mdc), ipart(msc,mdc), buff(mdc))
	call partinit(msc,mdc)
        
	do while (.true.)
	if (ioptt.gt.0) then
	  read (ndsd, '(a)', end=911, err=920) hedlin
	  write(nref,'(A)') trim(hedlin)		
	endif
	do ibounc = 1, nbounc
	  read (ndsd, '(a)', end=911, err=920) hedlin		
	  if (hedlin(1:6).eq.'NODATA' .or. hedlin(1:4).eq.'ZERO') then
	    spec=0.
	    write(nref,'(A)') trim(hedlin)		
	  else if (hedlin(1:6).eq.'FACTOR') then
	    read (ndsd, *, end=920) rfac
	    do ifre=1,msc
	      read(ndsd,*) buff
	      spec(ifre,:)=rfac*buff
	    enddo
            call partition(spec,msc,mdc,ipart,npart)
	    write(nref,'(A)') 'NPART'
	    write(nref, *) npart
	    do ifre=1,msc
	     WRITE (NREF,'(200(1X,I4))' ) (ipart(ifre,id), ID=1,MDC)
	    enddo
	    num=num+1

	  else
	    write(0,*) 'Format error ',hedlin
	    stop
	  endif
	enddo
!                
	enddo

911	close(ndsd)
	write(0,*) 'End of file: ',num,' spectra partitioned'

	deallocate(spcdir,spcsig,spec,imi,imo,ind,zp,ipart)

      enddo
      stop

920	close(ndsd)
	write(0,*) 'File read error'
	stop
      END


      






