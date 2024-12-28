import glob
import os
import re
import statistics

fout = open(f"GC_core_codon.csv", "w")
# Creating a new CSV to include average GC content per codon position

banner = ""
for l in range(1, 31):  # Adjusted to include 30 middle codons
    banner = f"{banner},codon_{l}"

fout.write(f"Accession,Species{banner}\n")

f = "Clean2.csv"
f_o = open(f, "r")
f_r = f_o.read()
f_o.close()

path = os.getcwd()
Lines = f_r.splitlines()[1:]
numgenomes = len(Lines)
cnt_bad = 0
cnt = 0
bad_list = []

for ln in Lines:
    cnt += 1
    bits = ln.split(",")
    accn = bits[0]
    if cnt % 10 == 0:
        print(f"Analyzing {accn}: {cnt} of {numgenomes}")
    isExist = os.path.exists(os.path.join(path, accn))

    if isExist:
        try:
            CDS_File = glob.glob(os.path.join(path, accn, "*.fna"))
            CDS_File_str = "".join(CDS_File)

            f_CDS1 = open(CDS_File_str, "r")
            f_CDS2 = f_CDS1.read()
            f_CDS1.close()

            f_CDS2_a = re.sub("\n>", "\n£", f_CDS2)
            f_CDS2_a = f_CDS2_a[1:]
            gene_list = f_CDS2_a.split("£")

            GC_by_codon = {i: [] for i in range(1, 31)}

            for gn in gene_list:
                fta = gn.splitlines()
                seq = "".join(fta[1:])

                if len(seq) > 90:  # Ensure the gene is long enough for middle 30 codons
                    all_codons = [seq[i:i + 3] for i in range(0, len(seq), 3)]
                    middle_pos = len(all_codons) // 2
                    middle_codons = all_codons[middle_pos - 15:middle_pos + 15]

                    for idx, codon in enumerate(middle_codons):
                        if len(codon) == 3:  # Ignore incomplete codons
                            GC = (codon.count("G") + codon.count("C")) / 3
                            GC_by_codon[idx + 1].append(GC)

            # Calculate average GC content for each codon position
            outline = f"{accn},{bits[7]}"
            for n in range(1, 31):
                if GC_by_codon[n]:
                    avg_gc = statistics.mean(GC_by_codon[n])
                    outline = f"{outline},{avg_gc:.3f}"
                else:
                    outline = f"{outline},"

            fout.write(f"{outline}\n")

        except Exception as E:
            cnt_bad += 1
            bad_list.append(accn)
            print(f"{accn} has no .fna file or encountered an error: {E}")
            continue

fout.close()


