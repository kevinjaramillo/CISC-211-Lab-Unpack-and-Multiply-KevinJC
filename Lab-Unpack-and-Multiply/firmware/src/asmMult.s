/*** asmMult.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Kevin Jaramillo"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */

.global packed_Value,a_Multiplicand,b_Multiplier,a_Sign,b_Sign,prod_Is_Neg,a_Abs,b_Abs,abs_Product,final_Product
.type packed_Value,%gnu_unique_object
.type a_Multiplicand,%gnu_unique_object
.type b_Multiplier,%gnu_unique_object
.type a_Sign,%gnu_unique_object
.type b_Sign,%gnu_unique_object
.type prod_Is_Neg,%gnu_unique_object
.type a_Abs,%gnu_unique_object
.type b_Abs,%gnu_unique_object
.type abs_Product,%gnu_unique_object
.type final_Product,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmMult gets called, you must set
 * them to 0 at the start of your code!
 */
packed_Value:    .word     0  
a_Multiplicand:  .word     0  
b_Multiplier:    .word     0  
a_Sign:          .word     0  
b_Sign:          .word     0 
prod_Is_Neg:     .word     0  
a_Abs:           .word     0  
b_Abs:           .word     0 
abs_Product:     .word     0
final_Product:   .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmMult
function description:
     output = asmMult ()
     
where:
     output: 
     
     function description: See Lab Instructions
     
     notes:
        None
          
********************************************************************/    
.global asmMult
.type asmMult,%function
asmMult:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
    /* Store packed arguments into 'packed_value' in memory*/
    ldr r4, =packed_value
    str r0, [r4]
    
    /* UNPACKING & MEMORY STORAGE of ARGUMENTS and their PROPERTIES */
    
    /* Loads memory address labels designated for unpacked values up front */
    ldr r4, =a_Multiplicand
    ldr r5, =b_Multiplier
    
    /* Unpack multiplicand from r0 and store in designated memory location*/
    asr r6, r0, 16
    str r6, [r4]
    
    /* Unpack multiplier from r0 and store in designated memory location*/
    ror r7, r0, 16
    asr r7, r0, 16
    str r7, [r5]
    
    /* Load memory address designated to the unpacked value's sign bits */
    ldr r4, =a_Sign
    ldr r5, =b_Sign
    
    mov r10, 0
    mov r11, 1
    
    /* Store multiplicand (r6) sign bit */
    tst r6, 0x80000000 /* Test sign bit of r6 using mask, and update APSR*/
    streq r10, [r4] /* If non-negative (eq), store 0 at a_Sign in memory */
    strne r11, [r4] /* If negative (ne), store 1 at a_Sign in memory */
    
    /* Stores abs value of multiplicand to a_Abs in memory */
    ldr r4, =a_Abs
    negne r6, r6 /* If multicand is negative, take 2's complement */
    str r6, [r4] /* Store abs value in r6 to a_abs in memory */
        
    /* Store multiplier (r7) sign bit */
    tst r7, 0x80000000 /* Test sign bit of r7 using mask, and update APSR*/
    streq r10, [r5] /* If non-negative (eq), store 0 at b_Sign in memory */
    strne r11, [r5] /* If negative (ne), store 1 at b_Sign in memory */    
    
    /* Stores abs value of multiplier to b_Abs in memory */
    ldr r5, =b_Abs
    negne r7, r7 /* If multiplier is negative, take 2's complement */
    str r7, [r5] /* Store abs value in r7 to b_abs in memory */
    
    /* Determine sign bit of (multiplicand * multiplier) and store in memory */
    ldr r4, =a_sign
    ldr r4, [r4]
    
    ldr r5, =b_sign
    ldr r5, [r5]
    
    xor r6, r4, r5 /* Determine sign of product if neg r6 = 1, else r6 = 0 */
    
    ldr r4, =prod_Is_Neg
    str r6, [r4] /* Store product sign into prod_Is_neg memory location */
    
   
    
    
    
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 

    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmMult return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




