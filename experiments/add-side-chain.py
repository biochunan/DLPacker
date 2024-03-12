"""
Add side chain atoms
"""
from pathlib import Path
import argparse, textwrap
from dlpacker import DLPacker

def cli():
    parser = argparse.ArgumentParser(description = 'Add side chain atoms',
                                     formatter_class = argparse.RawTextHelpFormatter,
                                     epilog=textwrap.dedent('''
        Example:
            python add-side-chain.py 3j42_2P.pdb
        '''))
    parser.add_argument('pdb_fp', type=Path, nargs='+', help = 'PDB file path')
    args = parser.parse_args()
    return args

def main(args):
    # reconstruct protein
    for fp in args.pdb_fp:
        dlp = DLPacker(fp)
        dlp.reconstruct_protein(order = 'sequence',
                                output_filename = (fp.parent / f'{fp.stem}_reconstructed.pdb').as_posix())

if __name__ == "__main__":
    main(cli())
