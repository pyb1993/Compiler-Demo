* File: hash_example.tm
* Standard prelude:
  0:    LDC  6,65535(0) 	load mp adress
  1:     ST  0,0(0) 	clear location 0
  2:    LDC  5,4095(0) 	load gp adress from location 1
  3:     ST  0,1(0) 	clear location 1
  4:    LDC  4,2000(0) 	load gp adress from location 1
  5:    LDC  2,60000(0) 	load first fp from location 2
  6:    LDC  3,60000(0) 	load first sp from location 2
  7:     ST  0,2(0) 	clear location 2
* End of standard prelude.
  8:    LDA  3,-1(3) 	stack expand
  9:    LDC  0,0(0) 	load integer const
 10:   PUSH  0,0(6) 	store exp
 11:    LDA  0,-62(5) 	load id adress
 12:   PUSH  0,0(6) 	push array adress to mp
 13:    POP  1,0(6) 	move the adress of ID
 14:    POP  0,0(6) 	copy bytes
 15:     ST  0,0(1) 	copy bytes
* function entry:
* malloc
 16:    LDA  3,-1(3) 	stack expand for function variable
 17:    LDC  0,20(0) 	get function adress
 18:     ST  0,-63(5) 	set function adress
 19:     GO  63,0,0 	go to label
 20:    MOV  1,2,0 	store the caller fp temporarily
 21:    MOV  2,3,0 	exchang the stack(context)
 22:   PUSH  1,0(3) 	push the caller fp
 23:   PUSH  0,0(3) 	push the return adress
 24:     LD  0,2(2) 	load id value
 25:   PUSH  0,0(6) 	store exp
 26:    POP  0,0(6) 	get malloc parameters
 27:  MALLOC  0,0(0) 	system call for malloc
 28:    MOV  3,2,0 	restore the caller sp
 29:     LD  2,0(2) 	resotre the caller fp
 30:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 31:  LABEL  63,0,0 	generate label
* function entry:
* free
 32:    LDA  3,-1(3) 	stack expand for function variable
 33:    LDC  0,36(0) 	get function adress
 34:     ST  0,-64(5) 	set function adress
 35:     GO  64,0,0 	go to label
 36:    MOV  1,2,0 	store the caller fp temporarily
 37:    MOV  2,3,0 	exchang the stack(context)
 38:   PUSH  1,0(3) 	push the caller fp
 39:   PUSH  0,0(3) 	push the return adress
 40:     LD  0,2(2) 	load id value
 41:   PUSH  0,0(6) 	store exp
 42:    POP  0,0(6) 	get free parameters
 43:  FREE  0,0(0) 	system call for free
 44:    MOV  3,2,0 	restore the caller sp
 45:     LD  2,0(2) 	resotre the caller fp
 46:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 47:  LABEL  64,0,0 	generate label
* function entry:
* printStr
 48:    LDA  3,-1(3) 	stack expand for function variable
 49:    LDC  0,52(0) 	get function adress
 50:     ST  0,-65(5) 	set function adress
 51:     GO  65,0,0 	go to label
 52:    MOV  1,2,0 	store the caller fp temporarily
 53:    MOV  2,3,0 	exchang the stack(context)
 54:   PUSH  1,0(3) 	push the caller fp
 55:   PUSH  0,0(3) 	push the return adress
* while stmt:
 56:  LABEL  66,0,0 	generate label
 57:     LD  0,2(2) 	load id value
 58:   PUSH  0,0(6) 	store exp
 59:    POP  0,0(6) 	pop the adress
 60:     LD  1,0(0) 	load bytes
 61:   PUSH  1,0(6) 	push bytes 
 62:    LDC  0,0(0) 	load integer const
 63:   PUSH  0,0(6) 	store exp
 64:    POP  1,0(6) 	pop right
 65:    POP  0,0(6) 	pop left
 66:    SUB  0,0,1 	op ==, convertd_type
 67:    JNE  0,2(7) 	br if true
 68:    LDC  0,0(0) 	false case
 69:    LDA  7,1(7) 	unconditional jmp
 70:    LDC  0,1(0) 	true case
 71:   PUSH  0,0(6) 	
 72:    POP  0,0(6) 	pop from the mp
 73:    JNE  0,1,7 	true case:, skip the break, execute the block code
 74:     GO  67,0,0 	go to label
 75:     LD  0,2(2) 	load id value
 76:   PUSH  0,0(6) 	store exp
 77:    POP  0,0(6) 	pop right
 78:     LD  0,2(2) 	load id value
 79:   PUSH  0,0(6) 	store exp
 80:     LD  0,2(2) 	load id value
 81:   PUSH  0,0(6) 	store exp
 82:    LDC  0,1(0) 	load integer const
 83:   PUSH  0,0(6) 	store exp
 84:    POP  0,0(6) 	load index value to ac
 85:    LDC  1,1,0 	load pointkind size
 86:    MUL  0,1,0 	compute the offset
 87:    POP  1,0(6) 	load lhs adress to ac1
 88:    ADD  0,1,0 	compute the real index adress
 89:   PUSH  0,0(6) 	op: load left
 90:    LDA  0,2(2) 	load id adress
 91:   PUSH  0,0(6) 	push array adress to mp
 92:    POP  1,0(6) 	move the adress of ID
 93:    POP  0,0(6) 	copy bytes
 94:     ST  0,0(1) 	copy bytes
 95:    POP  0,0(6) 	pop the adress
 96:     LD  1,0(0) 	load bytes
 97:   PUSH  1,0(6) 	push bytes 
 98:    POP  0,0(6) 	move result to register
 99:    OUT  0,1,0 	output value in register[ac / fac]
100:     GO  66,0,0 	go to label
3682:  LABEL  67,0,0 	generate label
3683:    MOV  3,2,0 	restore the caller sp
3684:     LD  2,0(2) 	resotre the caller fp
3685:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3686:  LABEL  65,0,0 	generate label
* call main function
* File: hash_example.tm
* Standard prelude:
3687:    LDC  6,65535(0) 	load mp adress
3688:     ST  0,0(0) 	clear location 0
3689:    LDC  5,4095(0) 	load gp adress from location 1
3690:     ST  0,1(0) 	clear location 1
3691:    LDC  4,2000(0) 	load gp adress from location 1
3692:    LDC  2,60000(0) 	load first fp from location 2
3693:    LDC  3,60000(0) 	load first sp from location 2
3694:     ST  0,2(0) 	clear location 2
* End of standard prelude.
3695:    LDA  3,-1(3) 	stack expand
3696:    LDA  3,-1(3) 	stack expand
3697:    LDA  3,-1(3) 	stack expand
3698:    LDA  3,-1(3) 	stack expand
3699:    LDA  3,-1(3) 	stack expand
3700:    LDA  3,-1(3) 	stack expand
* function entry:
* hash_func
3701:    LDA  3,-1(3) 	stack expand for function variable
3702:     GO  68,0,0 	go to label
3703:    MOV  1,2,0 	store the caller fp temporarily
3704:    MOV  2,3,0 	exchang the stack(context)
3705:   PUSH  1,0(3) 	push the caller fp
3706:   PUSH  0,0(3) 	push the return adress
3707:    MOV  3,2,0 	restore the caller sp
3708:     LD  2,0(2) 	resotre the caller fp
3709:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3710:  LABEL  68,0,0 	generate label
* function entry:
* get_idx
3711:    LDA  3,-1(3) 	stack expand for function variable
3712:     GO  69,0,0 	go to label
3713:    MOV  1,2,0 	store the caller fp temporarily
3714:    MOV  2,3,0 	exchang the stack(context)
3715:   PUSH  1,0(3) 	push the caller fp
3716:   PUSH  0,0(3) 	push the return adress
* push function parameters
3717:     LD  0,3(2) 	load id value
3718:   PUSH  0,0(6) 	store exp
3719:    POP  0,0(6) 	copy bytes
3720:   PUSH  0,0(3) 	PUSH bytes
3721:     LD  0,1(2) 	load env
3722:   PUSH  0,0(3) 	store env
* call function: 
* hash_func
3723:     LD  0,2(2) 	load id value
3724:   PUSH  0,0(6) 	store exp
3725:    POP  1,0,6 	load adress of lhs struct
3726:    LDC  0,3,0 	load offset of member
3727:    ADD  0,0,1 	compute the real adress if pointK
3728:   PUSH  0,0(6) 	
3729:    POP  0,0(6) 	load adress from mp
3730:     LD  1,0(0) 	copy bytes
3731:   PUSH  1,0(6) 	push a.x value into tmp
3732:    LDC  0,3734(0) 	store the return adress
3733:    POP  7,0(6) 	ujp to the function body
3734:    LDA  3,1(3) 	pop parameters
3735:    LDA  3,1(3) 	pop env
3736:     LD  0,2(2) 	load id value
3737:   PUSH  0,0(6) 	store exp
3738:    POP  1,0,6 	load adress of lhs struct
3739:    LDC  0,1,0 	load offset of member
3740:    ADD  0,0,1 	compute the real adress if pointK
3741:   PUSH  0,0(6) 	
3742:    POP  0,0(6) 	load adress from mp
3743:     LD  1,0(0) 	copy bytes
3744:   PUSH  1,0(6) 	push a.x value into tmp
3745:    POP  1,0(6) 	pop right
3746:    POP  0,0(6) 	pop left
3747:    MOD  0,0,1 	op %
3748:   PUSH  0,0(6) 	op: load left
3749:    MOV  3,2,0 	restore the caller sp
3750:     LD  2,0(2) 	resotre the caller fp
3751:  RETURN  0,-1,3 	return to the caller
3752:    MOV  3,2,0 	restore the caller sp
3753:     LD  2,0(2) 	resotre the caller fp
3754:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3755:  LABEL  69,0,0 	generate label
* function entry:
* slot_free
3756:    LDA  3,-1(3) 	stack expand for function variable
3757:     GO  70,0,0 	go to label
3758:    MOV  1,2,0 	store the caller fp temporarily
3759:    MOV  2,3,0 	exchang the stack(context)
3760:   PUSH  1,0(3) 	push the caller fp
3761:   PUSH  0,0(3) 	push the return adress
3762:    MOV  3,2,0 	restore the caller sp
3763:     LD  2,0(2) 	resotre the caller fp
3764:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3765:  LABEL  70,0,0 	generate label
* function entry:
* equal
3766:    LDA  3,-1(3) 	stack expand for function variable
3767:     GO  71,0,0 	go to label
3768:    MOV  1,2,0 	store the caller fp temporarily
3769:    MOV  2,3,0 	exchang the stack(context)
3770:   PUSH  1,0(3) 	push the caller fp
3771:   PUSH  0,0(3) 	push the return adress
3772:    MOV  3,2,0 	restore the caller sp
3773:     LD  2,0(2) 	resotre the caller fp
3774:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3775:  LABEL  71,0,0 	generate label
* function entry:
* put
3776:    LDA  3,-1(3) 	stack expand for function variable
3777:     GO  72,0,0 	go to label
3778:    MOV  1,2,0 	store the caller fp temporarily
3779:    MOV  2,3,0 	exchang the stack(context)
3780:   PUSH  1,0(3) 	push the caller fp
3781:   PUSH  0,0(3) 	push the return adress
3782:    LDA  3,-1(3) 	stack expand
* push function parameters
3783:     LD  0,3(2) 	load id value
3784:   PUSH  0,0(6) 	store exp
3785:    POP  0,0(6) 	copy bytes
3786:   PUSH  0,0(3) 	PUSH bytes
3787:     LD  0,2(2) 	load id value
3788:   PUSH  0,0(6) 	store exp
3789:    POP  0,0(6) 	
3790:   PUSH  0,0(3) 	
3791:     LD  0,1(2) 	load env
3792:   PUSH  0,0(3) 	store env
* call function: 
* get_idx
3793:     LD  0,2(2) 	load id value
3794:   PUSH  0,0(6) 	store exp
3795:    POP  1,0,6 	load adress of lhs struct
3796:    LDC  0,4,0 	load offset of member
3797:    ADD  0,0,1 	compute the real adress if pointK
3798:   PUSH  0,0(6) 	
3799:    POP  0,0(6) 	load adress from mp
3800:     LD  1,0(0) 	copy bytes
3801:   PUSH  1,0(6) 	push a.x value into tmp
3802:    LDC  0,3804(0) 	store the return adress
3803:    POP  7,0(6) 	ujp to the function body
3804:    LDA  3,1(3) 	pop parameters
3805:    LDA  3,1(3) 	pop env
3806:    LDA  3,1(3) 	pop parameters
3807:    LDA  0,-2(2) 	load id adress
3808:   PUSH  0,0(6) 	push array adress to mp
3809:    POP  1,0(6) 	move the adress of ID
3810:    POP  0,0(6) 	copy bytes
3811:     ST  0,0(1) 	copy bytes
3812:    LDA  3,-1(3) 	stack expand
3813:     LD  0,2(2) 	load id value
3814:   PUSH  0,0(6) 	store exp
3815:    POP  1,0,6 	load adress of lhs struct
3816:    LDC  0,0,0 	load offset of member
3817:    ADD  0,0,1 	compute the real adress if pointK
3818:   PUSH  0,0(6) 	
3819:    POP  0,0(6) 	load adress from mp
3820:     LD  1,0(0) 	copy bytes
3821:   PUSH  1,0(6) 	push a.x value into tmp
3822:     LD  0,-2(2) 	load id value
3823:   PUSH  0,0(6) 	store exp
3824:    POP  0,0(6) 	load index value to ac
3825:    LDC  1,3,0 	load pointkind size
3826:    MUL  0,1,0 	compute the offset
3827:    POP  1,0(6) 	load lhs adress to ac1
3828:    ADD  0,1,0 	compute the real index adress
3829:   PUSH  0,0(6) 	op: load left
3830:    LDA  0,-3(2) 	load id adress
3831:   PUSH  0,0(6) 	push array adress to mp
3832:    POP  1,0(6) 	move the adress of ID
3833:    POP  0,0(6) 	copy bytes
3834:     ST  0,0(1) 	copy bytes
3835:     LD  0,-3(2) 	load id value
3836:   PUSH  0,0(6) 	store exp
3837:    POP  1,0,6 	load adress of lhs struct
3838:    LDC  0,1,0 	load offset of member
3839:    ADD  0,0,1 	compute the real adress if pointK
3840:   PUSH  0,0(6) 	
3841:    POP  0,0(6) 	load adress from mp
3842:     LD  1,0(0) 	copy bytes
3843:   PUSH  1,0(6) 	push a.x value into tmp
3844:     LD  0,-62(5) 	load id value
3845:   PUSH  0,0(6) 	store exp
3846:    POP  1,0(6) 	pop right
3847:    POP  0,0(6) 	pop left
3848:    SUB  0,0,1 	op ==, convertd_type
3849:    JEQ  0,2(7) 	br if true
3850:    LDC  0,0(0) 	false case
3851:    LDA  7,1(7) 	unconditional jmp
3852:    LDC  0,1(0) 	true case
3853:   PUSH  0,0(6) 	
3854:    POP  0,0(6) 	pop from the mp
3855:    JNE  0,1,7 	true case:, execute if part
3856:     GO  73,0,0 	go to label
3857:     LD  0,3(2) 	load id value
3858:   PUSH  0,0(6) 	store exp
3859:     LD  0,-3(2) 	load id value
3860:   PUSH  0,0(6) 	store exp
3861:    POP  1,0,6 	load adress of lhs struct
3862:    LDC  0,1,0 	load offset of member
3863:    ADD  0,0,1 	compute the real adress if pointK
3864:   PUSH  0,0(6) 	
3865:    POP  1,0(6) 	move the adress of referenced
3866:    POP  0,0(6) 	copy bytes
3867:     ST  0,0(1) 	copy bytes
3868:     LD  0,4(2) 	load id value
3869:   PUSH  0,0(6) 	store exp
3870:     LD  0,-3(2) 	load id value
3871:   PUSH  0,0(6) 	store exp
3872:    POP  1,0,6 	load adress of lhs struct
3873:    LDC  0,2,0 	load offset of member
3874:    ADD  0,0,1 	compute the real adress if pointK
3875:   PUSH  0,0(6) 	
3876:    POP  1,0(6) 	move the adress of referenced
3877:    POP  0,0(6) 	copy bytes
3878:     ST  0,0(1) 	copy bytes
3879:     LD  0,-62(5) 	load id value
3880:   PUSH  0,0(6) 	store exp
3881:     LD  0,-3(2) 	load id value
3882:   PUSH  0,0(6) 	store exp
3883:    POP  1,0,6 	load adress of lhs struct
3884:    LDC  0,0,0 	load offset of member
3885:    ADD  0,0,1 	compute the real adress if pointK
3886:   PUSH  0,0(6) 	
3887:    POP  1,0(6) 	move the adress of referenced
3888:    POP  0,0(6) 	copy bytes
3889:     ST  0,0(1) 	copy bytes
3890:    MOV  3,2,0 	restore the caller sp
3891:     LD  2,0(2) 	resotre the caller fp
3892:  RETURN  0,-1,3 	return to the caller
3893:     GO  74,0,0 	go to label
3894:  LABEL  73,0,0 	generate label
* if: jump to else
3895:  LABEL  74,0,0 	generate label
3896:    LDA  3,-1(3) 	stack expand
* push function parameters
3897:    LDC  0,3,0 	load size of exp
3898:   PUSH  0,0(6) 	
3899:    POP  0,0(6) 	copy bytes
3900:   PUSH  0,0(3) 	PUSH bytes
3901:     LD  0,1(2) 	load env
3902:     LD  0,1(0) 	load env1
3903:   PUSH  0,0(3) 	store env
* call function: 
* malloc
3904:     LD  0,-63(5) 	load id value
3905:   PUSH  0,0(6) 	store exp
3906:    LDC  0,3908(0) 	store the return adress
3907:    POP  7,0(6) 	ujp to the function body
3908:    LDA  3,1(3) 	pop parameters
3909:    LDA  3,1(3) 	pop env
3910:    LDA  0,-4(2) 	load id adress
3911:   PUSH  0,0(6) 	push array adress to mp
3912:    POP  1,0(6) 	move the adress of ID
3913:    POP  0,0(6) 	copy bytes
3914:     ST  0,0(1) 	copy bytes
3915:     LD  0,3(2) 	load id value
3916:   PUSH  0,0(6) 	store exp
3917:     LD  0,-4(2) 	load id value
3918:   PUSH  0,0(6) 	store exp
3919:    POP  1,0,6 	load adress of lhs struct
3920:    LDC  0,1,0 	load offset of member
3921:    ADD  0,0,1 	compute the real adress if pointK
3922:   PUSH  0,0(6) 	
3923:    POP  1,0(6) 	move the adress of referenced
3924:    POP  0,0(6) 	copy bytes
3925:     ST  0,0(1) 	copy bytes
3926:     LD  0,4(2) 	load id value
3927:   PUSH  0,0(6) 	store exp
3928:     LD  0,-4(2) 	load id value
3929:   PUSH  0,0(6) 	store exp
3930:    POP  1,0,6 	load adress of lhs struct
3931:    LDC  0,2,0 	load offset of member
3932:    ADD  0,0,1 	compute the real adress if pointK
3933:   PUSH  0,0(6) 	
3934:    POP  1,0(6) 	move the adress of referenced
3935:    POP  0,0(6) 	copy bytes
3936:     ST  0,0(1) 	copy bytes
3937:     LD  0,-3(2) 	load id value
3938:   PUSH  0,0(6) 	store exp
3939:    POP  1,0,6 	load adress of lhs struct
3940:    LDC  0,0,0 	load offset of member
3941:    ADD  0,0,1 	compute the real adress if pointK
3942:   PUSH  0,0(6) 	
3943:    POP  0,0(6) 	load adress from mp
3944:     LD  1,0(0) 	copy bytes
3945:   PUSH  1,0(6) 	push a.x value into tmp
3946:     LD  0,-4(2) 	load id value
3947:   PUSH  0,0(6) 	store exp
3948:    POP  1,0,6 	load adress of lhs struct
3949:    LDC  0,0,0 	load offset of member
3950:    ADD  0,0,1 	compute the real adress if pointK
3951:   PUSH  0,0(6) 	
3952:    POP  1,0(6) 	move the adress of referenced
3953:    POP  0,0(6) 	copy bytes
3954:     ST  0,0(1) 	copy bytes
3955:     LD  0,-4(2) 	load id value
3956:   PUSH  0,0(6) 	store exp
3957:     LD  0,-3(2) 	load id value
3958:   PUSH  0,0(6) 	store exp
3959:    POP  1,0,6 	load adress of lhs struct
3960:    LDC  0,0,0 	load offset of member
3961:    ADD  0,0,1 	compute the real adress if pointK
3962:   PUSH  0,0(6) 	
3963:    POP  1,0(6) 	move the adress of referenced
3964:    POP  0,0(6) 	copy bytes
3965:     ST  0,0(1) 	copy bytes
3966:    MOV  3,2,0 	restore the caller sp
3967:     LD  2,0(2) 	resotre the caller fp
3968:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3969:  LABEL  72,0,0 	generate label
* function entry:
* get
3970:    LDA  3,-1(3) 	stack expand for function variable
3971:     GO  75,0,0 	go to label
3972:    MOV  1,2,0 	store the caller fp temporarily
3973:    MOV  2,3,0 	exchang the stack(context)
3974:   PUSH  1,0(3) 	push the caller fp
3975:   PUSH  0,0(3) 	push the return adress
3976:    LDA  3,-1(3) 	stack expand
* push function parameters
3977:     LD  0,3(2) 	load id value
3978:   PUSH  0,0(6) 	store exp
3979:    POP  0,0(6) 	copy bytes
3980:   PUSH  0,0(3) 	PUSH bytes
3981:     LD  0,2(2) 	load id value
3982:   PUSH  0,0(6) 	store exp
3983:    POP  0,0(6) 	
3984:   PUSH  0,0(3) 	
3985:     LD  0,1(2) 	load env
3986:   PUSH  0,0(3) 	store env
* call function: 
* get_idx
3987:     LD  0,2(2) 	load id value
3988:   PUSH  0,0(6) 	store exp
3989:    POP  1,0,6 	load adress of lhs struct
3990:    LDC  0,4,0 	load offset of member
3991:    ADD  0,0,1 	compute the real adress if pointK
3992:   PUSH  0,0(6) 	
3993:    POP  0,0(6) 	load adress from mp
3994:     LD  1,0(0) 	copy bytes
3995:   PUSH  1,0(6) 	push a.x value into tmp
3996:    LDC  0,3998(0) 	store the return adress
3997:    POP  7,0(6) 	ujp to the function body
3998:    LDA  3,1(3) 	pop parameters
3999:    LDA  3,1(3) 	pop env
4000:    LDA  3,1(3) 	pop parameters
4001:    LDA  0,-2(2) 	load id adress
4002:   PUSH  0,0(6) 	push array adress to mp
4003:    POP  1,0(6) 	move the adress of ID
4004:    POP  0,0(6) 	copy bytes
4005:     ST  0,0(1) 	copy bytes
4006:    LDA  3,-1(3) 	stack expand
4007:     LD  0,2(2) 	load id value
4008:   PUSH  0,0(6) 	store exp
4009:    POP  1,0,6 	load adress of lhs struct
4010:    LDC  0,0,0 	load offset of member
4011:    ADD  0,0,1 	compute the real adress if pointK
4012:   PUSH  0,0(6) 	
4013:    POP  0,0(6) 	load adress from mp
4014:     LD  1,0(0) 	copy bytes
4015:   PUSH  1,0(6) 	push a.x value into tmp
4016:     LD  0,-2(2) 	load id value
4017:   PUSH  0,0(6) 	store exp
4018:    POP  0,0(6) 	load index value to ac
4019:    LDC  1,3,0 	load pointkind size
4020:    MUL  0,1,0 	compute the offset
4021:    POP  1,0(6) 	load lhs adress to ac1
4022:    ADD  0,1,0 	compute the real index adress
4023:   PUSH  0,0(6) 	op: load left
4024:    LDA  0,-3(2) 	load id adress
4025:   PUSH  0,0(6) 	push array adress to mp
4026:    POP  1,0(6) 	move the adress of ID
4027:    POP  0,0(6) 	copy bytes
4028:     ST  0,0(1) 	copy bytes
* while stmt:
4029:  LABEL  76,0,0 	generate label
4030:     LD  0,-3(2) 	load id value
4031:   PUSH  0,0(6) 	store exp
4032:     LD  0,-62(5) 	load id value
4033:   PUSH  0,0(6) 	store exp
4034:    POP  1,0(6) 	pop right
4035:    POP  0,0(6) 	pop left
4036:    SUB  0,0,1 	op ==, convertd_type
4037:    JNE  0,2(7) 	br if true
4038:    LDC  0,0(0) 	false case
4039:    LDA  7,1(7) 	unconditional jmp
4040:    LDC  0,1(0) 	true case
4041:   PUSH  0,0(6) 	
4042:     LD  0,-3(2) 	load id value
4043:   PUSH  0,0(6) 	store exp
4044:    POP  1,0,6 	load adress of lhs struct
4045:    LDC  0,1,0 	load offset of member
4046:    ADD  0,0,1 	compute the real adress if pointK
4047:   PUSH  0,0(6) 	
4048:    POP  0,0(6) 	load adress from mp
4049:     LD  1,0(0) 	copy bytes
4050:   PUSH  1,0(6) 	push a.x value into tmp
4051:     LD  0,-62(5) 	load id value
4052:   PUSH  0,0(6) 	store exp
4053:    POP  1,0(6) 	pop right
4054:    POP  0,0(6) 	pop left
4055:    SUB  0,0,1 	op ==, convertd_type
4056:    JNE  0,2(7) 	br if true
4057:    LDC  0,0(0) 	false case
4058:    LDA  7,1(7) 	unconditional jmp
4059:    LDC  0,1(0) 	true case
4060:   PUSH  0,0(6) 	
4061:    POP  1,0(6) 	pop right
4062:    POP  0,0(6) 	pop left
4063:    JEQ  0,3(7) 	br if false
4064:    JEQ  1,2(7) 	br if false
4065:    LDC  0,1(0) 	true case
4066:    LDA  7,1(7) 	unconditional jmp
4067:    LDC  0,0(0) 	false case
4068:   PUSH  0,0(6) 	
* push function parameters
4069:     LD  0,-3(2) 	load id value
4070:   PUSH  0,0(6) 	store exp
4071:    POP  1,0,6 	load adress of lhs struct
4072:    LDC  0,1,0 	load offset of member
4073:    ADD  0,0,1 	compute the real adress if pointK
4074:   PUSH  0,0(6) 	
4075:    POP  0,0(6) 	load adress from mp
4076:     LD  1,0(0) 	copy bytes
4077:   PUSH  1,0(6) 	push a.x value into tmp
4078:    POP  0,0(6) 	copy bytes
4079:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
4080:     LD  0,3(2) 	load id value
4081:   PUSH  0,0(6) 	store exp
4082:    POP  0,0(6) 	copy bytes
4083:   PUSH  0,0(3) 	PUSH bytes
4084:     LD  0,1(2) 	load env
4085:   PUSH  0,0(3) 	store env
* call function: 
* equal
4086:     LD  0,2(2) 	load id value
4087:   PUSH  0,0(6) 	store exp
4088:    POP  1,0,6 	load adress of lhs struct
4089:    LDC  0,6,0 	load offset of member
4090:    ADD  0,0,1 	compute the real adress if pointK
4091:   PUSH  0,0(6) 	
4092:    POP  0,0(6) 	load adress from mp
4093:     LD  1,0(0) 	copy bytes
4094:   PUSH  1,0(6) 	push a.x value into tmp
4095:    LDC  0,4097(0) 	store the return adress
4096:    POP  7,0(6) 	ujp to the function body
4097:    LDA  3,2(3) 	pop parameters
4098:    LDA  3,1(3) 	pop env
4099:    LDC  0,1(0) 	load integer const
4100:   PUSH  0,0(6) 	store exp
4101:    POP  1,0(6) 	pop right
4102:    POP  0,0(6) 	pop left
4103:    SUB  0,0,1 	op ==, convertd_type
4104:    JNE  0,2(7) 	br if true
4105:    LDC  0,0(0) 	false case
4106:    LDA  7,1(7) 	unconditional jmp
4107:    LDC  0,1(0) 	true case
4108:   PUSH  0,0(6) 	
4109:    POP  1,0(6) 	pop right
4110:    POP  0,0(6) 	pop left
4111:    JEQ  0,3(7) 	br if false
4112:    JEQ  1,2(7) 	br if false
4113:    LDC  0,1(0) 	true case
4114:    LDA  7,1(7) 	unconditional jmp
4115:    LDC  0,0(0) 	false case
4116:   PUSH  0,0(6) 	
4117:    POP  0,0(6) 	pop from the mp
4118:    JNE  0,1,7 	true case:, skip the break, execute the block code
4119:     GO  77,0,0 	go to label
4120:     LD  0,-3(2) 	load id value
4121:   PUSH  0,0(6) 	store exp
4122:    POP  1,0,6 	load adress of lhs struct
4123:    LDC  0,0,0 	load offset of member
4124:    ADD  0,0,1 	compute the real adress if pointK
4125:   PUSH  0,0(6) 	
4126:    POP  0,0(6) 	load adress from mp
4127:     LD  1,0(0) 	copy bytes
4128:   PUSH  1,0(6) 	push a.x value into tmp
4129:    LDA  0,-3(2) 	load id adress
4130:   PUSH  0,0(6) 	push array adress to mp
4131:    POP  1,0(6) 	move the adress of ID
4132:    POP  0,0(6) 	copy bytes
4133:     ST  0,0(1) 	copy bytes
4134:     GO  76,0,0 	go to label
4135:  LABEL  77,0,0 	generate label
4136:     LD  0,-3(2) 	load id value
4137:   PUSH  0,0(6) 	store exp
4138:     LD  0,-62(5) 	load id value
4139:   PUSH  0,0(6) 	store exp
4140:    POP  1,0(6) 	pop right
4141:    POP  0,0(6) 	pop left
4142:    SUB  0,0,1 	op ==, convertd_type
4143:    JEQ  0,2(7) 	br if true
4144:    LDC  0,0(0) 	false case
4145:    LDA  7,1(7) 	unconditional jmp
4146:    LDC  0,1(0) 	true case
4147:   PUSH  0,0(6) 	
4148:     LD  0,-3(2) 	load id value
4149:   PUSH  0,0(6) 	store exp
4150:    POP  1,0,6 	load adress of lhs struct
4151:    LDC  0,1,0 	load offset of member
4152:    ADD  0,0,1 	compute the real adress if pointK
4153:   PUSH  0,0(6) 	
4154:    POP  0,0(6) 	load adress from mp
4155:     LD  1,0(0) 	copy bytes
4156:   PUSH  1,0(6) 	push a.x value into tmp
4157:     LD  0,-62(5) 	load id value
4158:   PUSH  0,0(6) 	store exp
4159:    POP  1,0(6) 	pop right
4160:    POP  0,0(6) 	pop left
4161:    SUB  0,0,1 	op ==, convertd_type
4162:    JEQ  0,2(7) 	br if true
4163:    LDC  0,0(0) 	false case
4164:    LDA  7,1(7) 	unconditional jmp
4165:    LDC  0,1(0) 	true case
4166:   PUSH  0,0(6) 	
4167:    POP  1,0(6) 	pop right
4168:    POP  0,0(6) 	pop left
4169:    JNE  0,3(7) 	br if true
4170:    JNE  1,2(7) 	br if true
4171:    LDC  0,0(0) 	false case
4172:    LDA  7,1(7) 	unconditional jmp
4173:    LDC  0,1(0) 	true case
4174:   PUSH  0,0(6) 	
4175:    POP  0,0(6) 	pop from the mp
4176:    JNE  0,1,7 	true case:, execute if part
4177:     GO  78,0,0 	go to label
4178:     LD  0,-62(5) 	load id value
4179:   PUSH  0,0(6) 	store exp
4180:    MOV  3,2,0 	restore the caller sp
4181:     LD  2,0(2) 	resotre the caller fp
4182:  RETURN  0,-1,3 	return to the caller
4183:     GO  79,0,0 	go to label
4184:  LABEL  78,0,0 	generate label
* if: jump to else
4185:  LABEL  79,0,0 	generate label
4186:     LD  0,-3(2) 	load id value
4187:   PUSH  0,0(6) 	store exp
4188:    POP  1,0,6 	load adress of lhs struct
4189:    LDC  0,2,0 	load offset of member
4190:    ADD  0,0,1 	compute the real adress if pointK
4191:   PUSH  0,0(6) 	
4192:    POP  0,0(6) 	load adress from mp
4193:     LD  1,0(0) 	copy bytes
4194:   PUSH  1,0(6) 	push a.x value into tmp
4195:    MOV  3,2,0 	restore the caller sp
4196:     LD  2,0(2) 	resotre the caller fp
4197:  RETURN  0,-1,3 	return to the caller
4198:    MOV  3,2,0 	restore the caller sp
4199:     LD  2,0(2) 	resotre the caller fp
4200:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
4201:  LABEL  75,0,0 	generate label
* function entry:
* delete
4202:    LDA  3,-1(3) 	stack expand for function variable
4203:     GO  80,0,0 	go to label
4204:    MOV  1,2,0 	store the caller fp temporarily
4205:    MOV  2,3,0 	exchang the stack(context)
4206:   PUSH  1,0(3) 	push the caller fp
4207:   PUSH  0,0(3) 	push the return adress
4208:    LDA  3,-1(3) 	stack expand
* push function parameters
4209:     LD  0,3(2) 	load id value
4210:   PUSH  0,0(6) 	store exp
4211:    POP  0,0(6) 	copy bytes
4212:   PUSH  0,0(3) 	PUSH bytes
4213:     LD  0,2(2) 	load id value
4214:   PUSH  0,0(6) 	store exp
4215:    POP  0,0(6) 	
4216:   PUSH  0,0(3) 	
4217:     LD  0,1(2) 	load env
4218:   PUSH  0,0(3) 	store env
* call function: 
* get_idx
4219:     LD  0,2(2) 	load id value
4220:   PUSH  0,0(6) 	store exp
4221:    POP  1,0,6 	load adress of lhs struct
4222:    LDC  0,4,0 	load offset of member
4223:    ADD  0,0,1 	compute the real adress if pointK
4224:   PUSH  0,0(6) 	
4225:    POP  0,0(6) 	load adress from mp
4226:     LD  1,0(0) 	copy bytes
4227:   PUSH  1,0(6) 	push a.x value into tmp
4228:    LDC  0,4230(0) 	store the return adress
4229:    POP  7,0(6) 	ujp to the function body
4230:    LDA  3,1(3) 	pop parameters
4231:    LDA  3,1(3) 	pop env
4232:    LDA  3,1(3) 	pop parameters
4233:    LDA  0,-2(2) 	load id adress
4234:   PUSH  0,0(6) 	push array adress to mp
4235:    POP  1,0(6) 	move the adress of ID
4236:    POP  0,0(6) 	copy bytes
4237:     ST  0,0(1) 	copy bytes
4238:    LDA  3,-1(3) 	stack expand
4239:     LD  0,2(2) 	load id value
4240:   PUSH  0,0(6) 	store exp
4241:    POP  1,0,6 	load adress of lhs struct
4242:    LDC  0,0,0 	load offset of member
4243:    ADD  0,0,1 	compute the real adress if pointK
4244:   PUSH  0,0(6) 	
4245:    POP  0,0(6) 	load adress from mp
4246:     LD  1,0(0) 	copy bytes
4247:   PUSH  1,0(6) 	push a.x value into tmp
4248:     LD  0,-2(2) 	load id value
4249:   PUSH  0,0(6) 	store exp
4250:    POP  0,0(6) 	load index value to ac
4251:    LDC  1,3,0 	load pointkind size
4252:    MUL  0,1,0 	compute the offset
4253:    POP  1,0(6) 	load lhs adress to ac1
4254:    ADD  0,1,0 	compute the real index adress
4255:   PUSH  0,0(6) 	op: load left
4256:    LDA  0,-3(2) 	load id adress
4257:   PUSH  0,0(6) 	push array adress to mp
4258:    POP  1,0(6) 	move the adress of ID
4259:    POP  0,0(6) 	copy bytes
4260:     ST  0,0(1) 	copy bytes
4261:    LDA  3,-1(3) 	stack expand
4262:     LD  0,-62(5) 	load id value
4263:   PUSH  0,0(6) 	store exp
4264:    LDA  0,-4(2) 	load id adress
4265:   PUSH  0,0(6) 	push array adress to mp
4266:    POP  1,0(6) 	move the adress of ID
4267:    POP  0,0(6) 	copy bytes
4268:     ST  0,0(1) 	copy bytes
* while stmt:
4269:  LABEL  81,0,0 	generate label
4270:     LD  0,-3(2) 	load id value
4271:   PUSH  0,0(6) 	store exp
4272:     LD  0,-62(5) 	load id value
4273:   PUSH  0,0(6) 	store exp
4274:    POP  1,0(6) 	pop right
4275:    POP  0,0(6) 	pop left
4276:    SUB  0,0,1 	op ==, convertd_type
4277:    JNE  0,2(7) 	br if true
4278:    LDC  0,0(0) 	false case
4279:    LDA  7,1(7) 	unconditional jmp
4280:    LDC  0,1(0) 	true case
4281:   PUSH  0,0(6) 	
4282:     LD  0,-3(2) 	load id value
4283:   PUSH  0,0(6) 	store exp
4284:    POP  1,0,6 	load adress of lhs struct
4285:    LDC  0,1,0 	load offset of member
4286:    ADD  0,0,1 	compute the real adress if pointK
4287:   PUSH  0,0(6) 	
4288:    POP  0,0(6) 	load adress from mp
4289:     LD  1,0(0) 	copy bytes
4290:   PUSH  1,0(6) 	push a.x value into tmp
4291:     LD  0,-62(5) 	load id value
4292:   PUSH  0,0(6) 	store exp
4293:    POP  1,0(6) 	pop right
4294:    POP  0,0(6) 	pop left
4295:    SUB  0,0,1 	op ==, convertd_type
4296:    JNE  0,2(7) 	br if true
4297:    LDC  0,0(0) 	false case
4298:    LDA  7,1(7) 	unconditional jmp
4299:    LDC  0,1(0) 	true case
4300:   PUSH  0,0(6) 	
4301:    POP  1,0(6) 	pop right
4302:    POP  0,0(6) 	pop left
4303:    JEQ  0,3(7) 	br if false
4304:    JEQ  1,2(7) 	br if false
4305:    LDC  0,1(0) 	true case
4306:    LDA  7,1(7) 	unconditional jmp
4307:    LDC  0,0(0) 	false case
4308:   PUSH  0,0(6) 	
* push function parameters
4309:     LD  0,-3(2) 	load id value
4310:   PUSH  0,0(6) 	store exp
4311:    POP  1,0,6 	load adress of lhs struct
4312:    LDC  0,1,0 	load offset of member
4313:    ADD  0,0,1 	compute the real adress if pointK
4314:   PUSH  0,0(6) 	
4315:    POP  0,0(6) 	load adress from mp
4316:     LD  1,0(0) 	copy bytes
4317:   PUSH  1,0(6) 	push a.x value into tmp
4318:    POP  0,0(6) 	copy bytes
4319:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
4320:     LD  0,3(2) 	load id value
4321:   PUSH  0,0(6) 	store exp
4322:    POP  0,0(6) 	copy bytes
4323:   PUSH  0,0(3) 	PUSH bytes
4324:     LD  0,1(2) 	load env
4325:   PUSH  0,0(3) 	store env
* call function: 
* equal
4326:     LD  0,2(2) 	load id value
4327:   PUSH  0,0(6) 	store exp
4328:    POP  1,0,6 	load adress of lhs struct
4329:    LDC  0,6,0 	load offset of member
4330:    ADD  0,0,1 	compute the real adress if pointK
4331:   PUSH  0,0(6) 	
4332:    POP  0,0(6) 	load adress from mp
4333:     LD  1,0(0) 	copy bytes
4334:   PUSH  1,0(6) 	push a.x value into tmp
4335:    LDC  0,4337(0) 	store the return adress
4336:    POP  7,0(6) 	ujp to the function body
4337:    LDA  3,2(3) 	pop parameters
4338:    LDA  3,1(3) 	pop env
4339:    LDC  0,1(0) 	load integer const
4340:   PUSH  0,0(6) 	store exp
4341:    POP  1,0(6) 	pop right
4342:    POP  0,0(6) 	pop left
4343:    SUB  0,0,1 	op ==, convertd_type
4344:    JNE  0,2(7) 	br if true
4345:    LDC  0,0(0) 	false case
4346:    LDA  7,1(7) 	unconditional jmp
4347:    LDC  0,1(0) 	true case
4348:   PUSH  0,0(6) 	
4349:    POP  1,0(6) 	pop right
4350:    POP  0,0(6) 	pop left
4351:    JEQ  0,3(7) 	br if false
4352:    JEQ  1,2(7) 	br if false
4353:    LDC  0,1(0) 	true case
4354:    LDA  7,1(7) 	unconditional jmp
4355:    LDC  0,0(0) 	false case
4356:   PUSH  0,0(6) 	
4357:    POP  0,0(6) 	pop from the mp
4358:    JNE  0,1,7 	true case:, skip the break, execute the block code
4359:     GO  82,0,0 	go to label
4360:     LD  0,-3(2) 	load id value
4361:   PUSH  0,0(6) 	store exp
4362:    LDA  0,-4(2) 	load id adress
4363:   PUSH  0,0(6) 	push array adress to mp
4364:    POP  1,0(6) 	move the adress of ID
4365:    POP  0,0(6) 	copy bytes
4366:     ST  0,0(1) 	copy bytes
4367:     LD  0,-3(2) 	load id value
4368:   PUSH  0,0(6) 	store exp
4369:    POP  1,0,6 	load adress of lhs struct
4370:    LDC  0,0,0 	load offset of member
4371:    ADD  0,0,1 	compute the real adress if pointK
4372:   PUSH  0,0(6) 	
4373:    POP  0,0(6) 	load adress from mp
4374:     LD  1,0(0) 	copy bytes
4375:   PUSH  1,0(6) 	push a.x value into tmp
4376:    LDA  0,-3(2) 	load id adress
4377:   PUSH  0,0(6) 	push array adress to mp
4378:    POP  1,0(6) 	move the adress of ID
4379:    POP  0,0(6) 	copy bytes
4380:     ST  0,0(1) 	copy bytes
4381:     GO  81,0,0 	go to label
4382:  LABEL  82,0,0 	generate label
4383:     LD  0,-3(2) 	load id value
4384:   PUSH  0,0(6) 	store exp
4385:     LD  0,-62(5) 	load id value
4386:   PUSH  0,0(6) 	store exp
4387:    POP  1,0(6) 	pop right
4388:    POP  0,0(6) 	pop left
4389:    SUB  0,0,1 	op ==, convertd_type
4390:    JEQ  0,2(7) 	br if true
4391:    LDC  0,0(0) 	false case
4392:    LDA  7,1(7) 	unconditional jmp
4393:    LDC  0,1(0) 	true case
4394:   PUSH  0,0(6) 	
4395:     LD  0,-3(2) 	load id value
4396:   PUSH  0,0(6) 	store exp
4397:    POP  1,0,6 	load adress of lhs struct
4398:    LDC  0,1,0 	load offset of member
4399:    ADD  0,0,1 	compute the real adress if pointK
4400:   PUSH  0,0(6) 	
4401:    POP  0,0(6) 	load adress from mp
4402:     LD  1,0(0) 	copy bytes
4403:   PUSH  1,0(6) 	push a.x value into tmp
4404:     LD  0,-62(5) 	load id value
4405:   PUSH  0,0(6) 	store exp
4406:    POP  1,0(6) 	pop right
4407:    POP  0,0(6) 	pop left
4408:    SUB  0,0,1 	op ==, convertd_type
4409:    JEQ  0,2(7) 	br if true
4410:    LDC  0,0(0) 	false case
4411:    LDA  7,1(7) 	unconditional jmp
4412:    LDC  0,1(0) 	true case
4413:   PUSH  0,0(6) 	
4414:    POP  1,0(6) 	pop right
4415:    POP  0,0(6) 	pop left
4416:    JNE  0,3(7) 	br if true
4417:    JNE  1,2(7) 	br if true
4418:    LDC  0,0(0) 	false case
4419:    LDA  7,1(7) 	unconditional jmp
4420:    LDC  0,1(0) 	true case
4421:   PUSH  0,0(6) 	
4422:    POP  0,0(6) 	pop from the mp
4423:    JNE  0,1,7 	true case:, execute if part
4424:     GO  83,0,0 	go to label
4425:    MOV  3,2,0 	restore the caller sp
4426:     LD  2,0(2) 	resotre the caller fp
4427:  RETURN  0,-1,3 	return to the caller
4428:     GO  84,0,0 	go to label
4429:  LABEL  83,0,0 	generate label
* if: jump to else
* push function parameters
4430:     LD  0,-3(2) 	load id value
4431:   PUSH  0,0(6) 	store exp
4432:    POP  0,0(6) 	copy bytes
4433:   PUSH  0,0(3) 	PUSH bytes
4434:     LD  0,1(2) 	load env
4435:   PUSH  0,0(3) 	store env
* call function: 
* slot_free
4436:     LD  0,2(2) 	load id value
4437:   PUSH  0,0(6) 	store exp
4438:    POP  1,0,6 	load adress of lhs struct
4439:    LDC  0,5,0 	load offset of member
4440:    ADD  0,0,1 	compute the real adress if pointK
4441:   PUSH  0,0(6) 	
4442:    POP  0,0(6) 	load adress from mp
4443:     LD  1,0(0) 	copy bytes
4444:   PUSH  1,0(6) 	push a.x value into tmp
4445:    LDC  0,4447(0) 	store the return adress
4446:    POP  7,0(6) 	ujp to the function body
4447:    LDA  3,1(3) 	pop parameters
4448:    LDA  3,1(3) 	pop env
4449:     LD  0,-62(5) 	load id value
4450:   PUSH  0,0(6) 	store exp
4451:     LD  0,-3(2) 	load id value
4452:   PUSH  0,0(6) 	store exp
4453:    POP  1,0,6 	load adress of lhs struct
4454:    LDC  0,1,0 	load offset of member
4455:    ADD  0,0,1 	compute the real adress if pointK
4456:   PUSH  0,0(6) 	
4457:    POP  1,0(6) 	move the adress of referenced
4458:    POP  0,0(6) 	copy bytes
4459:     ST  0,0(1) 	copy bytes
4460:     LD  0,-62(5) 	load id value
4461:   PUSH  0,0(6) 	store exp
4462:     LD  0,-3(2) 	load id value
4463:   PUSH  0,0(6) 	store exp
4464:    POP  1,0,6 	load adress of lhs struct
4465:    LDC  0,2,0 	load offset of member
4466:    ADD  0,0,1 	compute the real adress if pointK
4467:   PUSH  0,0(6) 	
4468:    POP  1,0(6) 	move the adress of referenced
4469:    POP  0,0(6) 	copy bytes
4470:     ST  0,0(1) 	copy bytes
4471:     LD  0,-4(2) 	load id value
4472:   PUSH  0,0(6) 	store exp
4473:     LD  0,-62(5) 	load id value
4474:   PUSH  0,0(6) 	store exp
4475:    POP  1,0(6) 	pop right
4476:    POP  0,0(6) 	pop left
4477:    SUB  0,0,1 	op ==, convertd_type
4478:    JNE  0,2(7) 	br if true
4479:    LDC  0,0(0) 	false case
4480:    LDA  7,1(7) 	unconditional jmp
4481:    LDC  0,1(0) 	true case
4482:   PUSH  0,0(6) 	
4483:    POP  0,0(6) 	pop from the mp
4484:    JNE  0,1,7 	true case:, execute if part
4485:     GO  85,0,0 	go to label
4486:     LD  0,-3(2) 	load id value
4487:   PUSH  0,0(6) 	store exp
4488:    POP  1,0,6 	load adress of lhs struct
4489:    LDC  0,0,0 	load offset of member
4490:    ADD  0,0,1 	compute the real adress if pointK
4491:   PUSH  0,0(6) 	
4492:    POP  0,0(6) 	load adress from mp
4493:     LD  1,0(0) 	copy bytes
4494:   PUSH  1,0(6) 	push a.x value into tmp
4495:     LD  0,-4(2) 	load id value
4496:   PUSH  0,0(6) 	store exp
4497:    POP  1,0,6 	load adress of lhs struct
4498:    LDC  0,0,0 	load offset of member
4499:    ADD  0,0,1 	compute the real adress if pointK
4500:   PUSH  0,0(6) 	
4501:    POP  1,0(6) 	move the adress of referenced
4502:    POP  0,0(6) 	copy bytes
4503:     ST  0,0(1) 	copy bytes
4504:     GO  86,0,0 	go to label
4505:  LABEL  85,0,0 	generate label
* if: jump to else
4506:  LABEL  86,0,0 	generate label
4507:  LABEL  84,0,0 	generate label
4508:    MOV  3,2,0 	restore the caller sp
4509:     LD  2,0(2) 	resotre the caller fp
4510:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
4511:  LABEL  80,0,0 	generate label
* function entry:
* createHash
4512:    LDA  3,-1(3) 	stack expand for function variable
4513:    LDC  0,4516(0) 	get function adress
4514:     ST  0,-66(5) 	set function adress
4515:     GO  87,0,0 	go to label
4516:    MOV  1,2,0 	store the caller fp temporarily
4517:    MOV  2,3,0 	exchang the stack(context)
4518:   PUSH  1,0(3) 	push the caller fp
4519:   PUSH  0,0(3) 	push the return adress
4520:     LD  0,2(2) 	load id value
4521:   PUSH  0,0(6) 	store exp
4522:    LDC  0,0(0) 	load integer const
4523:   PUSH  0,0(6) 	store exp
4524:    POP  1,0(6) 	pop right
4525:    POP  0,0(6) 	pop left
4526:    SUB  0,0,1 	op <
4527:    JLE  0,2(7) 	br if true
4528:    LDC  0,0(0) 	false case
4529:    LDA  7,1(7) 	unconditional jmp
4530:    LDC  0,1(0) 	true case
4531:   PUSH  0,0(6) 	
4532:    POP  0,0(6) 	pop from the mp
4533:    JNE  0,1,7 	true case:, execute if part
4534:     GO  88,0,0 	go to label
4535:    LDC  0,5(0) 	load integer const
4536:   PUSH  0,0(6) 	store exp
4537:    LDA  0,2(2) 	load id adress
4538:   PUSH  0,0(6) 	push array adress to mp
4539:    POP  1,0(6) 	move the adress of ID
4540:    POP  0,0(6) 	copy bytes
4541:     ST  0,0(1) 	copy bytes
4542:     GO  89,0,0 	go to label
4543:  LABEL  88,0,0 	generate label
* if: jump to else
4544:  LABEL  89,0,0 	generate label
4545:    LDA  3,-10(3) 	stack expand
4546:    LDC  1,3703(0) 	get function adress from struct
4547:     ST  1,4(3) 	Init Struct Instance
4548:    LDC  1,3713(0) 	get function adress from struct
4549:     ST  1,5(3) 	Init Struct Instance
4550:    LDC  1,3758(0) 	get function adress from struct
4551:     ST  1,6(3) 	Init Struct Instance
4552:    LDC  1,3768(0) 	get function adress from struct
4553:     ST  1,7(3) 	Init Struct Instance
4554:    LDC  1,3778(0) 	get function adress from struct
4555:     ST  1,8(3) 	Init Struct Instance
4556:    LDC  1,3972(0) 	get function adress from struct
4557:     ST  1,9(3) 	Init Struct Instance
4558:    LDC  1,4204(0) 	get function adress from struct
4559:     ST  1,10(3) 	Init Struct Instance
4560:     LD  0,2(2) 	load id value
4561:   PUSH  0,0(6) 	store exp
4562:    LDA  0,-11(2) 	load id adress
4563:   PUSH  0,0(6) 	push array adress to mp
4564:    POP  1,0,6 	load adress of lhs struct
4565:    LDC  0,1,0 	load offset of member
4566:    ADD  0,0,1 	compute the real adress if pointK
4567:   PUSH  0,0(6) 	
4568:    POP  1,0(6) 	move the adress of referenced
4569:    POP  0,0(6) 	copy bytes
4570:     ST  0,0(1) 	copy bytes
4571:    LDC  0,0(0) 	load integer const
4572:   PUSH  0,0(6) 	store exp
4573:    LDA  0,-11(2) 	load id adress
4574:   PUSH  0,0(6) 	push array adress to mp
4575:    POP  1,0,6 	load adress of lhs struct
4576:    LDC  0,2,0 	load offset of member
4577:    ADD  0,0,1 	compute the real adress if pointK
4578:   PUSH  0,0(6) 	
4579:    POP  1,0(6) 	move the adress of referenced
4580:    POP  0,0(6) 	copy bytes
4581:     ST  0,0(1) 	copy bytes
* push function parameters
4582:    LDC  0,3,0 	load size of exp
4583:   PUSH  0,0(6) 	
4584:    POP  0,0(6) 	copy bytes
4585:   PUSH  0,0(3) 	PUSH bytes
4586:     LD  0,1(2) 	load env
4587:   PUSH  0,0(3) 	store env
* call function: 
* malloc
4588:     LD  0,-63(5) 	load id value
4589:   PUSH  0,0(6) 	store exp
4590:    LDC  0,4592(0) 	store the return adress
4591:    POP  7,0(6) 	ujp to the function body
4592:    LDA  3,1(3) 	pop parameters
4593:    LDA  3,1(3) 	pop env
4594:     LD  0,2(2) 	load id value
4595:   PUSH  0,0(6) 	store exp
4596:    POP  1,0(6) 	pop right
4597:    POP  0,0(6) 	pop left
4598:    MUL  0,0,1 	op *
4599:   PUSH  0,0(6) 	op: load left
4600:    LDA  0,-11(2) 	load id adress
4601:   PUSH  0,0(6) 	push array adress to mp
4602:    POP  1,0,6 	load adress of lhs struct
4603:    LDC  0,0,0 	load offset of member
4604:    ADD  0,0,1 	compute the real adress if pointK
4605:   PUSH  0,0(6) 	
4606:    POP  1,0(6) 	move the adress of referenced
4607:    POP  0,0(6) 	copy bytes
4608:     ST  0,0(1) 	copy bytes
4609:    LDA  3,-1(3) 	stack expand
4610:    LDC  0,0(0) 	load integer const
4611:   PUSH  0,0(6) 	store exp
4612:    LDA  0,-12(2) 	load id adress
4613:   PUSH  0,0(6) 	push array adress to mp
4614:    POP  1,0(6) 	move the adress of ID
4615:    POP  0,0(6) 	copy bytes
4616:     ST  0,0(1) 	copy bytes
* while stmt:
4617:  LABEL  90,0,0 	generate label
4618:     LD  0,-12(2) 	load id value
4619:   PUSH  0,0(6) 	store exp
4620:     LD  0,2(2) 	load id value
4621:   PUSH  0,0(6) 	store exp
4622:    POP  1,0(6) 	pop right
4623:    POP  0,0(6) 	pop left
4624:    SUB  0,0,1 	op <
4625:    JLT  0,2(7) 	br if true
4626:    LDC  0,0(0) 	false case
4627:    LDA  7,1(7) 	unconditional jmp
4628:    LDC  0,1(0) 	true case
4629:   PUSH  0,0(6) 	
4630:    POP  0,0(6) 	pop from the mp
4631:    JNE  0,1,7 	true case:, skip the break, execute the block code
4632:     GO  91,0,0 	go to label
4633:     LD  0,-62(5) 	load id value
4634:   PUSH  0,0(6) 	store exp
4635:    LDA  0,-11(2) 	load id adress
4636:   PUSH  0,0(6) 	push array adress to mp
4637:    POP  1,0,6 	load adress of lhs struct
4638:    LDC  0,0,0 	load offset of member
4639:    ADD  0,0,1 	compute the real adress if pointK
4640:   PUSH  0,0(6) 	
4641:    POP  0,0(6) 	load adress from mp
4642:     LD  1,0(0) 	copy bytes
4643:   PUSH  1,0(6) 	push a.x value into tmp
4644:     LD  0,-12(2) 	load id value
4645:   PUSH  0,0(6) 	store exp
4646:    POP  0,0(6) 	pop right
4647:     LD  0,-12(2) 	load id value
4648:   PUSH  0,0(6) 	store exp
4649:     LD  0,-12(2) 	load id value
4650:   PUSH  0,0(6) 	store exp
4651:    LDC  0,1(0) 	load integer const
4652:   PUSH  0,0(6) 	store exp
4653:    POP  1,0(6) 	pop right
4654:    POP  0,0(6) 	pop left
4655:    ADD  0,0,1 	op +
4656:   PUSH  0,0(6) 	op: load left
4657:    LDA  0,-12(2) 	load id adress
4658:   PUSH  0,0(6) 	push array adress to mp
4659:    POP  1,0(6) 	move the adress of ID
4660:    POP  0,0(6) 	copy bytes
4661:     ST  0,0(1) 	copy bytes
4662:    POP  0,0(6) 	load index value to ac
4663:    LDC  1,3,0 	load array size
4664:    MUL  0,1,0 	compute the offset
4665:    POP  1,0(6) 	load lhs adress to ac1
4666:    ADD  0,0,1 	compute the real index adress a[index]
4667:   PUSH  0,0(6) 	push the adress mode into mp
4668:    POP  1,0,6 	load adress of lhs struct
4669:    LDC  0,1,0 	load offset of member
4670:    ADD  0,0,1 	compute the real adress if pointK
4671:   PUSH  0,0(6) 	
4672:    POP  1,0(6) 	move the adress of referenced
4673:    POP  0,0(6) 	copy bytes
4674:     ST  0,0(1) 	copy bytes
4675:     GO  90,0,0 	go to label
4676:  LABEL  91,0,0 	generate label
4677:     LD  0,-11(2) 	load id value
4678:   PUSH  0,0(6) 	store exp
4679:     LD  0,-10(2) 	load id value
4680:   PUSH  0,0(6) 	store exp
4681:     LD  0,-9(2) 	load id value
4682:   PUSH  0,0(6) 	store exp
4683:     LD  0,-8(2) 	load id value
4684:   PUSH  0,0(6) 	store exp
4685:     LD  0,-7(2) 	load id value
4686:   PUSH  0,0(6) 	store exp
4687:     LD  0,-6(2) 	load id value
4688:   PUSH  0,0(6) 	store exp
4689:     LD  0,-5(2) 	load id value
4690:   PUSH  0,0(6) 	store exp
4691:     LD  0,-4(2) 	load id value
4692:   PUSH  0,0(6) 	store exp
4693:     LD  0,-3(2) 	load id value
4694:   PUSH  0,0(6) 	store exp
4695:     LD  0,-2(2) 	load id value
4696:   PUSH  0,0(6) 	store exp
4697:    MOV  3,2,0 	restore the caller sp
4698:     LD  2,0(2) 	resotre the caller fp
4699:  RETURN  0,-1,3 	return to the caller
4700:    MOV  3,2,0 	restore the caller sp
4701:     LD  2,0(2) 	resotre the caller fp
4702:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
4703:  LABEL  87,0,0 	generate label
* call main function
* File: hash_example.tm
* Standard prelude:
4704:    LDC  6,65535(0) 	load mp adress
4705:     ST  0,0(0) 	clear location 0
4706:    LDC  5,4095(0) 	load gp adress from location 1
4707:     ST  0,1(0) 	clear location 1
4708:    LDC  4,2000(0) 	load gp adress from location 1
4709:    LDC  2,60000(0) 	load first fp from location 2
4710:    LDC  3,60000(0) 	load first sp from location 2
4711:     ST  0,2(0) 	clear location 2
* End of standard prelude.
* function entry:
* makeHash
4712:    LDA  3,-1(3) 	stack expand for function variable
4713:    LDC  0,4716(0) 	get function adress
4714:     ST  0,-67(5) 	set function adress
4715:     GO  92,0,0 	go to label
4716:    MOV  1,2,0 	store the caller fp temporarily
4717:    MOV  2,3,0 	exchang the stack(context)
4718:   PUSH  1,0(3) 	push the caller fp
4719:   PUSH  0,0(3) 	push the return adress
* function entry:
* equal
4720:    LDA  3,-1(3) 	stack expand for function variable
4721:    LDC  0,4724(0) 	get function adress
4722:     ST  0,-2(2) 	set function adress
4723:     GO  93,0,0 	go to label
4724:    MOV  1,2,0 	store the caller fp temporarily
4725:    MOV  2,3,0 	exchang the stack(context)
4726:   PUSH  1,0(3) 	push the caller fp
4727:   PUSH  0,0(3) 	push the return adress
* while stmt:
4728:  LABEL  94,0,0 	generate label
4729:     LD  0,2(2) 	load id value
4730:   PUSH  0,0(6) 	store exp
4731:    POP  0,0(6) 	pop the adress
4732:     LD  1,0(0) 	load bytes
4733:   PUSH  1,0(6) 	push bytes 
4734:    LDC  0,0(0) 	load integer const
4735:   PUSH  0,0(6) 	store exp
4736:    POP  1,0(6) 	pop right
4737:    POP  0,0(6) 	pop left
4738:    SUB  0,0,1 	op ==, convertd_type
4739:    JNE  0,2(7) 	br if true
4740:    LDC  0,0(0) 	false case
4741:    LDA  7,1(7) 	unconditional jmp
4742:    LDC  0,1(0) 	true case
4743:   PUSH  0,0(6) 	
4744:     LD  0,3(2) 	load id value
4745:   PUSH  0,0(6) 	store exp
4746:    POP  0,0(6) 	pop the adress
4747:     LD  1,0(0) 	load bytes
4748:   PUSH  1,0(6) 	push bytes 
4749:    LDC  0,0(0) 	load integer const
4750:   PUSH  0,0(6) 	store exp
4751:    POP  1,0(6) 	pop right
4752:    POP  0,0(6) 	pop left
4753:    SUB  0,0,1 	op ==, convertd_type
4754:    JNE  0,2(7) 	br if true
4755:    LDC  0,0(0) 	false case
4756:    LDA  7,1(7) 	unconditional jmp
4757:    LDC  0,1(0) 	true case
4758:   PUSH  0,0(6) 	
4759:    POP  1,0(6) 	pop right
4760:    POP  0,0(6) 	pop left
4761:    JEQ  0,3(7) 	br if false
4762:    JEQ  1,2(7) 	br if false
4763:    LDC  0,1(0) 	true case
4764:    LDA  7,1(7) 	unconditional jmp
4765:    LDC  0,0(0) 	false case
4766:   PUSH  0,0(6) 	
4767:     LD  0,2(2) 	load id value
4768:   PUSH  0,0(6) 	store exp
4769:    POP  0,0(6) 	pop the adress
4770:     LD  1,0(0) 	load bytes
4771:   PUSH  1,0(6) 	push bytes 
4772:     LD  0,3(2) 	load id value
4773:   PUSH  0,0(6) 	store exp
4774:    POP  0,0(6) 	pop the adress
4775:     LD  1,0(0) 	load bytes
4776:   PUSH  1,0(6) 	push bytes 
4777:    POP  1,0(6) 	pop right
4778:    POP  0,0(6) 	pop left
4779:    SUB  0,0,1 	op ==, convertd_type
4780:    JEQ  0,2(7) 	br if true
4781:    LDC  0,0(0) 	false case
4782:    LDA  7,1(7) 	unconditional jmp
4783:    LDC  0,1(0) 	true case
4784:   PUSH  0,0(6) 	
4785:    POP  1,0(6) 	pop right
4786:    POP  0,0(6) 	pop left
4787:    JEQ  0,3(7) 	br if false
4788:    JEQ  1,2(7) 	br if false
4789:    LDC  0,1(0) 	true case
4790:    LDA  7,1(7) 	unconditional jmp
4791:    LDC  0,0(0) 	false case
4792:   PUSH  0,0(6) 	
4793:    POP  0,0(6) 	pop from the mp
4794:    JNE  0,1,7 	true case:, skip the break, execute the block code
4795:     GO  95,0,0 	go to label
4796:     LD  0,2(2) 	load id value
4797:   PUSH  0,0(6) 	store exp
4798:    POP  0,0(6) 	pop right
4799:     LD  0,2(2) 	load id value
4800:   PUSH  0,0(6) 	store exp
4801:    LDC  0,1(0) 	load integer const
4802:   PUSH  0,0(6) 	store exp
4803:    POP  0,0(6) 	load index value to ac
4804:    LDC  1,1,0 	load pointkind size
4805:    MUL  0,1,0 	compute the offset
4806:    POP  1,0(6) 	load lhs adress to ac1
4807:    ADD  0,1,0 	compute the real index adress
4808:   PUSH  0,0(6) 	op: load left
4809:    LDA  0,2(2) 	load id adress
4810:   PUSH  0,0(6) 	push array adress to mp
4811:    POP  1,0(6) 	move the adress of ID
4812:    POP  0,0(6) 	copy bytes
4813:     ST  0,0(1) 	copy bytes
4814:     LD  0,3(2) 	load id value
4815:   PUSH  0,0(6) 	store exp
4816:    POP  0,0(6) 	pop right
4817:     LD  0,3(2) 	load id value
4818:   PUSH  0,0(6) 	store exp
4819:    LDC  0,1(0) 	load integer const
4820:   PUSH  0,0(6) 	store exp
4821:    POP  0,0(6) 	load index value to ac
4822:    LDC  1,1,0 	load pointkind size
4823:    MUL  0,1,0 	compute the offset
4824:    POP  1,0(6) 	load lhs adress to ac1
4825:    ADD  0,1,0 	compute the real index adress
4826:   PUSH  0,0(6) 	op: load left
4827:    LDA  0,3(2) 	load id adress
4828:   PUSH  0,0(6) 	push array adress to mp
4829:    POP  1,0(6) 	move the adress of ID
4830:    POP  0,0(6) 	copy bytes
4831:     ST  0,0(1) 	copy bytes
4832:     GO  94,0,0 	go to label
4833:  LABEL  95,0,0 	generate label
4834:     LD  0,2(2) 	load id value
4835:   PUSH  0,0(6) 	store exp
4836:    POP  0,0(6) 	pop the adress
4837:     LD  1,0(0) 	load bytes
4838:   PUSH  1,0(6) 	push bytes 
4839:    LDC  0,0(0) 	load integer const
4840:   PUSH  0,0(6) 	store exp
4841:    POP  1,0(6) 	pop right
4842:    POP  0,0(6) 	pop left
4843:    SUB  0,0,1 	op ==, convertd_type
4844:    JEQ  0,2(7) 	br if true
4845:    LDC  0,0(0) 	false case
4846:    LDA  7,1(7) 	unconditional jmp
4847:    LDC  0,1(0) 	true case
4848:   PUSH  0,0(6) 	
4849:     LD  0,3(2) 	load id value
4850:   PUSH  0,0(6) 	store exp
4851:    POP  0,0(6) 	pop the adress
4852:     LD  1,0(0) 	load bytes
4853:   PUSH  1,0(6) 	push bytes 
4854:    LDC  0,0(0) 	load integer const
4855:   PUSH  0,0(6) 	store exp
4856:    POP  1,0(6) 	pop right
4857:    POP  0,0(6) 	pop left
4858:    SUB  0,0,1 	op ==, convertd_type
4859:    JEQ  0,2(7) 	br if true
4860:    LDC  0,0(0) 	false case
4861:    LDA  7,1(7) 	unconditional jmp
4862:    LDC  0,1(0) 	true case
4863:   PUSH  0,0(6) 	
4864:    POP  1,0(6) 	pop right
4865:    POP  0,0(6) 	pop left
4866:    JEQ  0,3(7) 	br if false
4867:    JEQ  1,2(7) 	br if false
4868:    LDC  0,1(0) 	true case
4869:    LDA  7,1(7) 	unconditional jmp
4870:    LDC  0,0(0) 	false case
4871:   PUSH  0,0(6) 	
4872:    MOV  3,2,0 	restore the caller sp
4873:     LD  2,0(2) 	resotre the caller fp
4874:  RETURN  0,-1,3 	return to the caller
4875:    MOV  3,2,0 	restore the caller sp
4876:     LD  2,0(2) 	resotre the caller fp
4877:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
4878:  LABEL  93,0,0 	generate label
* function entry:
* hash_func
4879:    LDA  3,-1(3) 	stack expand for function variable
4880:    LDC  0,4883(0) 	get function adress
4881:     ST  0,-3(2) 	set function adress
4882:     GO  96,0,0 	go to label
4883:    MOV  1,2,0 	store the caller fp temporarily
4884:    MOV  2,3,0 	exchang the stack(context)
4885:   PUSH  1,0(3) 	push the caller fp
4886:   PUSH  0,0(3) 	push the return adress
4887:    LDA  3,-1(3) 	stack expand
4888:    LDC  0,0(0) 	load integer const
4889:   PUSH  0,0(6) 	store exp
4890:    LDA  0,-2(2) 	load id adress
4891:   PUSH  0,0(6) 	push array adress to mp
4892:    POP  1,0(6) 	move the adress of ID
4893:    POP  0,0(6) 	copy bytes
4894:     ST  0,0(1) 	copy bytes
* while stmt:
4895:  LABEL  97,0,0 	generate label
4896:     LD  0,2(2) 	load id value
4897:   PUSH  0,0(6) 	store exp
4898:    POP  0,0(6) 	pop the adress
4899:     LD  1,0(0) 	load bytes
4900:   PUSH  1,0(6) 	push bytes 
4901:    LDC  0,0(0) 	load integer const
4902:   PUSH  0,0(6) 	store exp
4903:    POP  1,0(6) 	pop right
4904:    POP  0,0(6) 	pop left
4905:    SUB  0,0,1 	op ==, convertd_type
4906:    JNE  0,2(7) 	br if true
4907:    LDC  0,0(0) 	false case
4908:    LDA  7,1(7) 	unconditional jmp
4909:    LDC  0,1(0) 	true case
4910:   PUSH  0,0(6) 	
4911:    POP  0,0(6) 	pop from the mp
4912:    JNE  0,1,7 	true case:, skip the break, execute the block code
4913:     GO  98,0,0 	go to label
4914:     LD  0,-2(2) 	load id value
4915:   PUSH  0,0(6) 	store exp
4916:     LD  0,2(2) 	load id value
4917:   PUSH  0,0(6) 	store exp
4918:    POP  0,0(6) 	pop the adress
4919:     LD  1,0(0) 	load bytes
4920:   PUSH  1,0(6) 	push bytes 
4921:    POP  1,0(6) 	pop right
4922:    POP  0,0(6) 	pop left
4923:    ADD  0,0,1 	op +
4924:   PUSH  0,0(6) 	op: load left
4925:    LDA  0,-2(2) 	load id adress
4926:   PUSH  0,0(6) 	push array adress to mp
4927:    POP  1,0(6) 	move the adress of ID
4928:    POP  0,0(6) 	copy bytes
4929:     ST  0,0(1) 	copy bytes
4930:     LD  0,2(2) 	load id value
4931:   PUSH  0,0(6) 	store exp
4932:    POP  0,0(6) 	pop right
4933:     LD  0,2(2) 	load id value
4934:   PUSH  0,0(6) 	store exp
4935:    LDC  0,1(0) 	load integer const
4936:   PUSH  0,0(6) 	store exp
4937:    POP  0,0(6) 	load index value to ac
4938:    LDC  1,1,0 	load pointkind size
4939:    MUL  0,1,0 	compute the offset
4940:    POP  1,0(6) 	load lhs adress to ac1
4941:    ADD  0,1,0 	compute the real index adress
4942:   PUSH  0,0(6) 	op: load left
4943:    LDA  0,2(2) 	load id adress
4944:   PUSH  0,0(6) 	push array adress to mp
4945:    POP  1,0(6) 	move the adress of ID
4946:    POP  0,0(6) 	copy bytes
4947:     ST  0,0(1) 	copy bytes
4948:     GO  97,0,0 	go to label
4949:  LABEL  98,0,0 	generate label
4950:     LD  0,-2(2) 	load id value
4951:   PUSH  0,0(6) 	store exp
4952:    MOV  3,2,0 	restore the caller sp
4953:     LD  2,0(2) 	resotre the caller fp
4954:  RETURN  0,-1,3 	return to the caller
4955:    MOV  3,2,0 	restore the caller sp
4956:     LD  2,0(2) 	resotre the caller fp
4957:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
4958:  LABEL  96,0,0 	generate label
4959:    LDA  3,-10(3) 	stack expand
4960:    LDC  1,3703(0) 	get function adress from struct
4961:     ST  1,4(3) 	Init Struct Instance
4962:    LDC  1,3713(0) 	get function adress from struct
4963:     ST  1,5(3) 	Init Struct Instance
4964:    LDC  1,3758(0) 	get function adress from struct
4965:     ST  1,6(3) 	Init Struct Instance
4966:    LDC  1,3768(0) 	get function adress from struct
4967:     ST  1,7(3) 	Init Struct Instance
4968:    LDC  1,3778(0) 	get function adress from struct
4969:     ST  1,8(3) 	Init Struct Instance
4970:    LDC  1,3972(0) 	get function adress from struct
4971:     ST  1,9(3) 	Init Struct Instance
4972:    LDC  1,4204(0) 	get function adress from struct
4973:     ST  1,10(3) 	Init Struct Instance
* push function parameters
4974:    LDC  0,0(0) 	load integer const
4975:   PUSH  0,0(6) 	store exp
4976:    POP  0,0(6) 	copy bytes
4977:   PUSH  0,0(3) 	PUSH bytes
4978:     LD  0,1(2) 	load env
4979:   PUSH  0,0(3) 	store env
* call function: 
* createHash
4980:     LD  0,-66(5) 	load id value
4981:   PUSH  0,0(6) 	store exp
4982:    LDC  0,4984(0) 	store the return adress
4983:    POP  7,0(6) 	ujp to the function body
4984:    LDA  3,1(3) 	pop parameters
4985:    LDA  3,1(3) 	pop env
4986:    LDA  0,-13(2) 	load id adress
4987:   PUSH  0,0(6) 	push array adress to mp
4988:    POP  1,0(6) 	move the adress of ID
4989:    POP  0,0(6) 	copy bytes
4990:     ST  0,9(1) 	copy bytes
4991:    POP  0,0(6) 	copy bytes
4992:     ST  0,8(1) 	copy bytes
4993:    POP  0,0(6) 	copy bytes
4994:     ST  0,7(1) 	copy bytes
4995:    POP  0,0(6) 	copy bytes
4996:     ST  0,6(1) 	copy bytes
4997:    POP  0,0(6) 	copy bytes
4998:     ST  0,5(1) 	copy bytes
4999:    POP  0,0(6) 	copy bytes
5000:     ST  0,4(1) 	copy bytes
5001:    POP  0,0(6) 	copy bytes
5002:     ST  0,3(1) 	copy bytes
5003:    POP  0,0(6) 	copy bytes
5004:     ST  0,2(1) 	copy bytes
5005:    POP  0,0(6) 	copy bytes
5006:     ST  0,1(1) 	copy bytes
5007:    POP  0,0(6) 	copy bytes
5008:     ST  0,0(1) 	copy bytes
5009:     LD  0,-2(2) 	load id value
5010:   PUSH  0,0(6) 	store exp
5011:    LDA  0,-13(2) 	load id adress
5012:   PUSH  0,0(6) 	push array adress to mp
5013:    POP  1,0,6 	load adress of lhs struct
5014:    LDC  0,6,0 	load offset of member
5015:    ADD  0,0,1 	compute the real adress if pointK
5016:   PUSH  0,0(6) 	
5017:    POP  1,0(6) 	move the adress of referenced
5018:    POP  0,0(6) 	copy bytes
5019:     ST  0,0(1) 	copy bytes
5020:     LD  0,-3(2) 	load id value
5021:   PUSH  0,0(6) 	store exp
5022:    LDA  0,-13(2) 	load id adress
5023:   PUSH  0,0(6) 	push array adress to mp
5024:    POP  1,0,6 	load adress of lhs struct
5025:    LDC  0,3,0 	load offset of member
5026:    ADD  0,0,1 	compute the real adress if pointK
5027:   PUSH  0,0(6) 	
5028:    POP  1,0(6) 	move the adress of referenced
5029:    POP  0,0(6) 	copy bytes
5030:     ST  0,0(1) 	copy bytes
5031:     LD  0,-13(2) 	load id value
5032:   PUSH  0,0(6) 	store exp
5033:     LD  0,-12(2) 	load id value
5034:   PUSH  0,0(6) 	store exp
5035:     LD  0,-11(2) 	load id value
5036:   PUSH  0,0(6) 	store exp
5037:     LD  0,-10(2) 	load id value
5038:   PUSH  0,0(6) 	store exp
5039:     LD  0,-9(2) 	load id value
5040:   PUSH  0,0(6) 	store exp
5041:     LD  0,-8(2) 	load id value
5042:   PUSH  0,0(6) 	store exp
5043:     LD  0,-7(2) 	load id value
5044:   PUSH  0,0(6) 	store exp
5045:     LD  0,-6(2) 	load id value
5046:   PUSH  0,0(6) 	store exp
5047:     LD  0,-5(2) 	load id value
5048:   PUSH  0,0(6) 	store exp
5049:     LD  0,-4(2) 	load id value
5050:   PUSH  0,0(6) 	store exp
5051:    MOV  3,2,0 	restore the caller sp
5052:     LD  2,0(2) 	resotre the caller fp
5053:  RETURN  0,-1,3 	return to the caller
5054:    MOV  3,2,0 	restore the caller sp
5055:     LD  2,0(2) 	resotre the caller fp
5056:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
5057:  LABEL  92,0,0 	generate label
* function entry:
* main
5058:    LDC  0,5061(0) 	get function adress
5059:     ST  0,-68(5) 	set function adress
5060:     GO  99,0,0 	go to label
5061:    MOV  1,2,0 	store the caller fp temporarily
5062:    MOV  2,3,0 	exchang the stack(context)
5063:   PUSH  1,0(3) 	push the caller fp
5064:   PUSH  0,0(3) 	push the return adress
5065:    LDA  3,-10(3) 	stack expand
5066:    LDC  1,3703(0) 	get function adress from struct
5067:     ST  1,4(3) 	Init Struct Instance
5068:    LDC  1,3713(0) 	get function adress from struct
5069:     ST  1,5(3) 	Init Struct Instance
5070:    LDC  1,3758(0) 	get function adress from struct
5071:     ST  1,6(3) 	Init Struct Instance
5072:    LDC  1,3768(0) 	get function adress from struct
5073:     ST  1,7(3) 	Init Struct Instance
5074:    LDC  1,3778(0) 	get function adress from struct
5075:     ST  1,8(3) 	Init Struct Instance
5076:    LDC  1,3972(0) 	get function adress from struct
5077:     ST  1,9(3) 	Init Struct Instance
5078:    LDC  1,4204(0) 	get function adress from struct
5079:     ST  1,10(3) 	Init Struct Instance
5080:     LD  0,1(2) 	load env
5081:   PUSH  0,0(3) 	store env
* call function: 
* makeHash
5082:     LD  0,-67(5) 	load id value
5083:   PUSH  0,0(6) 	store exp
5084:    LDC  0,5086(0) 	store the return adress
5085:    POP  7,0(6) 	ujp to the function body
5086:    LDA  3,0(3) 	pop parameters
5087:    LDA  3,1(3) 	pop env
5088:    LDA  0,-11(2) 	load id adress
5089:   PUSH  0,0(6) 	push array adress to mp
5090:    POP  1,0(6) 	move the adress of ID
5091:    POP  0,0(6) 	copy bytes
5092:     ST  0,9(1) 	copy bytes
5093:    POP  0,0(6) 	copy bytes
5094:     ST  0,8(1) 	copy bytes
5095:    POP  0,0(6) 	copy bytes
5096:     ST  0,7(1) 	copy bytes
5097:    POP  0,0(6) 	copy bytes
5098:     ST  0,6(1) 	copy bytes
5099:    POP  0,0(6) 	copy bytes
5100:     ST  0,5(1) 	copy bytes
5101:    POP  0,0(6) 	copy bytes
5102:     ST  0,4(1) 	copy bytes
5103:    POP  0,0(6) 	copy bytes
5104:     ST  0,3(1) 	copy bytes
5105:    POP  0,0(6) 	copy bytes
5106:     ST  0,2(1) 	copy bytes
5107:    POP  0,0(6) 	copy bytes
5108:     ST  0,1(1) 	copy bytes
5109:    POP  0,0(6) 	copy bytes
5110:     ST  0,0(1) 	copy bytes
* push function parameters
5111:    LDC  0,50(0) 	load char const
5112:     ST  0,-75(4) 	store exp
5113:    LDC  0,51(0) 	load char const
5114:     ST  0,-74(4) 	store exp
5115:    LDC  0,52(0) 	load char const
5116:     ST  0,-73(4) 	store exp
5117:    LDC  0,53(0) 	load char const
5118:     ST  0,-72(4) 	store exp
5119:    LDA  0,-75(4) 	load char const
5120:   PUSH  0,0(6) 	store exp
5121:    POP  0,0(6) 	copy bytes
5122:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
5123:    LDC  0,49(0) 	load char const
5124:     ST  0,-70(4) 	store exp
5125:    LDA  0,-70(4) 	load char const
5126:   PUSH  0,0(6) 	store exp
5127:    POP  0,0(6) 	copy bytes
5128:   PUSH  0,0(3) 	PUSH bytes
5129:    LDA  0,-11(2) 	load id adress
5130:   PUSH  0,0(6) 	push array adress to mp
5131:    POP  0,0(6) 	
5132:   PUSH  0,0(3) 	
5133:    LDA  0,0(2) 	load env
5134:   PUSH  0,0(3) 	store env
* call function: 
* put
5135:    LDA  0,-11(2) 	load id adress
5136:   PUSH  0,0(6) 	push array adress to mp
5137:    POP  1,0,6 	load adress of lhs struct
5138:    LDC  0,7,0 	load offset of member
5139:    ADD  0,0,1 	compute the real adress if pointK
5140:   PUSH  0,0(6) 	
5141:    POP  0,0(6) 	load adress from mp
5142:     LD  1,0(0) 	copy bytes
5143:   PUSH  1,0(6) 	push a.x value into tmp
5144:    LDC  0,5146(0) 	store the return adress
5145:    POP  7,0(6) 	ujp to the function body
5146:    LDA  3,2(3) 	pop parameters
5147:    LDA  3,1(3) 	pop env
5148:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
5149:    LDC  0,49(0) 	load char const
5150:     ST  0,-77(4) 	store exp
5151:    LDA  0,-77(4) 	load char const
5152:   PUSH  0,0(6) 	store exp
5153:    POP  0,0(6) 	copy bytes
5154:   PUSH  0,0(3) 	PUSH bytes
5155:    LDA  0,-11(2) 	load id adress
5156:   PUSH  0,0(6) 	push array adress to mp
5157:    POP  0,0(6) 	
5158:   PUSH  0,0(3) 	
5159:    LDA  0,0(2) 	load env
5160:   PUSH  0,0(3) 	store env
* call function: 
* get
5161:    LDA  0,-11(2) 	load id adress
5162:   PUSH  0,0(6) 	push array adress to mp
5163:    POP  1,0,6 	load adress of lhs struct
5164:    LDC  0,8,0 	load offset of member
5165:    ADD  0,0,1 	compute the real adress if pointK
5166:   PUSH  0,0(6) 	
5167:    POP  0,0(6) 	load adress from mp
5168:     LD  1,0(0) 	copy bytes
5169:   PUSH  1,0(6) 	push a.x value into tmp
5170:    LDC  0,5172(0) 	store the return adress
5171:    POP  7,0(6) 	ujp to the function body
5172:    LDA  3,1(3) 	pop parameters
5173:    LDA  3,1(3) 	pop env
5174:    LDA  3,1(3) 	pop parameters
5175:    POP  0,0(6) 	copy bytes
5176:   PUSH  0,0(3) 	PUSH bytes
5177:     LD  0,1(2) 	load env
5178:   PUSH  0,0(3) 	store env
* call function: 
* printStr
5179:     LD  0,-65(5) 	load id value
5180:   PUSH  0,0(6) 	store exp
5181:    LDC  0,5183(0) 	store the return adress
5182:    POP  7,0(6) 	ujp to the function body
5183:    LDA  3,1(3) 	pop parameters
5184:    LDA  3,1(3) 	pop env
* push function parameters
5185:    LDC  0,102(0) 	load char const
5186:     ST  0,-92(4) 	store exp
5187:    LDC  0,117(0) 	load char const
5188:     ST  0,-91(4) 	store exp
5189:    LDC  0,99(0) 	load char const
5190:     ST  0,-90(4) 	store exp
5191:    LDC  0,107(0) 	load char const
5192:     ST  0,-89(4) 	store exp
5193:    LDC  0,32(0) 	load char const
5194:     ST  0,-88(4) 	store exp
5195:    LDC  0,121(0) 	load char const
5196:     ST  0,-87(4) 	store exp
5197:    LDC  0,111(0) 	load char const
5198:     ST  0,-86(4) 	store exp
5199:    LDC  0,117(0) 	load char const
5200:     ST  0,-85(4) 	store exp
5201:    LDA  0,-92(4) 	load char const
5202:   PUSH  0,0(6) 	store exp
5203:    POP  0,0(6) 	copy bytes
5204:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
5205:    LDC  0,110(0) 	load char const
5206:     ST  0,-83(4) 	store exp
5207:    LDC  0,105(0) 	load char const
5208:     ST  0,-82(4) 	store exp
5209:    LDC  0,104(0) 	load char const
5210:     ST  0,-81(4) 	store exp
5211:    LDC  0,97(0) 	load char const
5212:     ST  0,-80(4) 	store exp
5213:    LDC  0,111(0) 	load char const
5214:     ST  0,-79(4) 	store exp
5215:    LDA  0,-83(4) 	load char const
5216:   PUSH  0,0(6) 	store exp
5217:    POP  0,0(6) 	copy bytes
5218:   PUSH  0,0(3) 	PUSH bytes
5219:    LDA  0,-11(2) 	load id adress
5220:   PUSH  0,0(6) 	push array adress to mp
5221:    POP  0,0(6) 	
5222:   PUSH  0,0(3) 	
5223:    LDA  0,0(2) 	load env
5224:   PUSH  0,0(3) 	store env
* call function: 
* put
5225:    LDA  0,-11(2) 	load id adress
5226:   PUSH  0,0(6) 	push array adress to mp
5227:    POP  1,0,6 	load adress of lhs struct
5228:    LDC  0,7,0 	load offset of member
5229:    ADD  0,0,1 	compute the real adress if pointK
5230:   PUSH  0,0(6) 	
5231:    POP  0,0(6) 	load adress from mp
5232:     LD  1,0(0) 	copy bytes
5233:   PUSH  1,0(6) 	push a.x value into tmp
5234:    LDC  0,5236(0) 	store the return adress
5235:    POP  7,0(6) 	ujp to the function body
5236:    LDA  3,2(3) 	pop parameters
5237:    LDA  3,1(3) 	pop env
5238:    LDA  3,1(3) 	pop parameters
* push function parameters
5239:    LDC  0,49(0) 	load char const
5240:     ST  0,-94(4) 	store exp
5241:    LDA  0,-94(4) 	load char const
5242:   PUSH  0,0(6) 	store exp
5243:    POP  0,0(6) 	copy bytes
5244:   PUSH  0,0(3) 	PUSH bytes
5245:    LDA  0,-11(2) 	load id adress
5246:   PUSH  0,0(6) 	push array adress to mp
5247:    POP  0,0(6) 	
5248:   PUSH  0,0(3) 	
5249:    LDA  0,0(2) 	load env
5250:   PUSH  0,0(3) 	store env
* call function: 
* delete
5251:    LDA  0,-11(2) 	load id adress
5252:   PUSH  0,0(6) 	push array adress to mp
5253:    POP  1,0,6 	load adress of lhs struct
5254:    LDC  0,9,0 	load offset of member
5255:    ADD  0,0,1 	compute the real adress if pointK
5256:   PUSH  0,0(6) 	
5257:    POP  0,0(6) 	load adress from mp
5258:     LD  1,0(0) 	copy bytes
5259:   PUSH  1,0(6) 	push a.x value into tmp
5260:    LDC  0,5262(0) 	store the return adress
5261:    POP  7,0(6) 	ujp to the function body
5262:    LDA  3,1(3) 	pop parameters
5263:    LDA  3,1(3) 	pop env
5264:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
5265:    LDC  0,49(0) 	load char const
5266:     ST  0,-96(4) 	store exp
5267:    LDA  0,-96(4) 	load char const
5268:   PUSH  0,0(6) 	store exp
5269:    POP  0,0(6) 	copy bytes
5270:   PUSH  0,0(3) 	PUSH bytes
5271:    LDA  0,-11(2) 	load id adress
5272:   PUSH  0,0(6) 	push array adress to mp
5273:    POP  0,0(6) 	
5274:   PUSH  0,0(3) 	
5275:    LDA  0,0(2) 	load env
5276:   PUSH  0,0(3) 	store env
* call function: 
* get
5277:    LDA  0,-11(2) 	load id adress
5278:   PUSH  0,0(6) 	push array adress to mp
5279:    POP  1,0,6 	load adress of lhs struct
5280:    LDC  0,8,0 	load offset of member
5281:    ADD  0,0,1 	compute the real adress if pointK
5282:   PUSH  0,0(6) 	
5283:    POP  0,0(6) 	load adress from mp
5284:     LD  1,0(0) 	copy bytes
5285:   PUSH  1,0(6) 	push a.x value into tmp
5286:    LDC  0,5288(0) 	store the return adress
5287:    POP  7,0(6) 	ujp to the function body
5288:    LDA  3,1(3) 	pop parameters
5289:    LDA  3,1(3) 	pop env
5290:    LDA  3,1(3) 	pop parameters
5291:    POP  0,0(6) 	copy bytes
5292:   PUSH  0,0(3) 	PUSH bytes
5293:     LD  0,1(2) 	load env
5294:   PUSH  0,0(3) 	store env
* call function: 
* printStr
5295:     LD  0,-65(5) 	load id value
5296:   PUSH  0,0(6) 	store exp
5297:    LDC  0,5299(0) 	store the return adress
5298:    POP  7,0(6) 	ujp to the function body
5299:    LDA  3,1(3) 	pop parameters
5300:    LDA  3,1(3) 	pop env
* push function parameters
* push function parameters
5301:    LDC  0,110(0) 	load char const
5302:     ST  0,-102(4) 	store exp
5303:    LDC  0,105(0) 	load char const
5304:     ST  0,-101(4) 	store exp
5305:    LDC  0,104(0) 	load char const
5306:     ST  0,-100(4) 	store exp
5307:    LDC  0,97(0) 	load char const
5308:     ST  0,-99(4) 	store exp
5309:    LDC  0,111(0) 	load char const
5310:     ST  0,-98(4) 	store exp
5311:    LDA  0,-102(4) 	load char const
5312:   PUSH  0,0(6) 	store exp
5313:    POP  0,0(6) 	copy bytes
5314:   PUSH  0,0(3) 	PUSH bytes
5315:    LDA  0,-11(2) 	load id adress
5316:   PUSH  0,0(6) 	push array adress to mp
5317:    POP  0,0(6) 	
5318:   PUSH  0,0(3) 	
5319:    LDA  0,0(2) 	load env
5320:   PUSH  0,0(3) 	store env
* call function: 
* get
5321:    LDA  0,-11(2) 	load id adress
5322:   PUSH  0,0(6) 	push array adress to mp
5323:    POP  1,0,6 	load adress of lhs struct
5324:    LDC  0,8,0 	load offset of member
5325:    ADD  0,0,1 	compute the real adress if pointK
5326:   PUSH  0,0(6) 	
5327:    POP  0,0(6) 	load adress from mp
5328:     LD  1,0(0) 	copy bytes
5329:   PUSH  1,0(6) 	push a.x value into tmp
5330:    LDC  0,5332(0) 	store the return adress
5331:    POP  7,0(6) 	ujp to the function body
5332:    LDA  3,1(3) 	pop parameters
5333:    LDA  3,1(3) 	pop env
5334:    LDA  3,1(3) 	pop parameters
5335:    POP  0,0(6) 	copy bytes
5336:   PUSH  0,0(3) 	PUSH bytes
5337:     LD  0,1(2) 	load env
5338:   PUSH  0,0(3) 	store env
* call function: 
* printStr
5339:     LD  0,-65(5) 	load id value
5340:   PUSH  0,0(6) 	store exp
5341:    LDC  0,5343(0) 	store the return adress
5342:    POP  7,0(6) 	ujp to the function body
5343:    LDA  3,1(3) 	pop parameters
5344:    LDA  3,1(3) 	pop env
5345:    MOV  3,2,0 	restore the caller sp
5346:     LD  2,0(2) 	resotre the caller fp
5347:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
5348:  LABEL  99,0,0 	generate label
* call main function
5349:     LD  1,-68(5) 	get main function adress
5350:    LDC  0,5352(0) 	store the return adress
5351:    LDA  7,0(1) 	ujp to the function body
5352:   HALT  0,0,0 	
