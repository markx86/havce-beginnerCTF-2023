ENTRY(shellcode)
OUTPUT_FORMAT(binary)

SECTIONS
{
	. = 0x0;
	.text ALIGN(0x0) :
	{
		*(.text)
	}

	/DISCARD/ :
	{
		*(.comment)
		*(.eh_frame_hdr)
		*(.eh_frame)
	}
}
