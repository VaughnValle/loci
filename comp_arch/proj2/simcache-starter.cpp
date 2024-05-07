/*
CS-UY 2214
Adapted from Jeff Epstein
Starter code for E20 cache Simulator
simcache.cpp
*/

#include <cstddef>
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <limits>
#include <iomanip>
#include <regex>`

using namespace std;


// --------------- Caching Simulation here

class Block{
    public:
        bool valid;
        int tag = -1;
        Block(): valid(false){}
        Block(int tag): tag(tag), valid(true){}
};

//Row Class that holds a vector of Blocks based of assoc
class Row{
    public:
        Row() {}

        Row(int rows) : rows(rows){
            blocks.resize(rows, Block(-1)); // Resizes vector of blocks to assoc
        }

        bool load_block(int tag, int assoc){ // Loads the values of tag into blocks and checks for a hit.
            bool found = false;
            Block temp(tag); // Temp block to push into the deque
            for(int i = 0; i < blocks.size(); i++){
                if(blocks[i].tag == tag){ // Checks for a hit. If there is a hit return a true and erase the existing block that was a hit
                    found = true;
                    blocks.erase(blocks.begin() + i);
                }
            }
            blocks.push_front(temp); // Push temp block to front no matte hit or miss
            if(blocks.size() > assoc){ // If block size is greater than assoc then get rid of the least used Block aka the back of deque
                blocks.pop_back(); 
            }
            return found; 
        }

        void store_block(int tag, int assoc){ // Storeing for SW
            Block temp(tag);
            blocks.push_front(temp); // SW always pushes
            if(blocks.size() > assoc){ // If block size is greater than assoc then get rid of the least used Block aka the back of deque
                blocks.pop_back();
            }
        }
        
    private:
        int rows;
        deque<Block> blocks;
};


class Cache {
	public:
        Cache() {}
        Cache (string name_in, int size_in, int assoc_in, int blocksize_in) : name(name_in), size(size_in), assoc(assoc_in), blocksize(blocksize_in){
			rowsize = size/(blocksize * assoc);
			rows.resize(rowsize);
			print_cache_config(name, size, assoc, blocksize, rowsize); // Prints out the cache identifiers
		}
		void refresh(uint16_t addr){ // Updates the values of block row and tag for each new memory address
		    block = addr / blocksize;
		    row = block % rowsize;
		    tag = block / rowsize;
		}
		void sw(uint16_t addr){ // Calls Row.store_block and prints an according log entry
		    rows[row].store_block(tag, assoc);
		    print_log_entry(name, "SW", pc, addr, row);
		}
		bool lw(uint16_t addr){ // Calls Row.load_block and prints an according log entry
		    if(rows[row].load_block(tag, assoc)){ // Checks for Hit or Miss
			    print_log_entry(name, "HIT", pc, addr, row);
			    return true;
		    }else{
			    print_log_entry(name, "MISS", pc, addr, row);
			    return false;
		    }
		}
	private:
        string name = "";
        int size;
        int assoc;
        int blocksize;
        int rowsize;
        int block;
        int row;
        int tag;
        vector <Row> rows;
};

// ------------------------------------------



// ----------- E20 Simulator

// Some helpful constant values that we'll be using.
size_t const static NUM_REGS = 8;
size_t const static MEM_SIZE = 1<<13;
size_t const static REG_SIZE = 1<<16;

// --- Global Variables
bool halt = false; // For ending loops

// Registers
int regA, regB, regC; // Reg as integers

// Unsigned integers variables
unsigned int imm; // Immediate value
unsigned int mem[MEM_SIZE];
unsigned int pc = 0;

// Registers initialized as capped 16-bit unsigned integers
uint16_t regs[NUM_REGS] = {};

/*
    Loads an E20 machine code file into the list
    provided by mem. We assume that mem is
    large enough to hold the values in the machine
    code file.

    @param f Open file to read from
    @param mem Array represetnting memory into which to read program
*/

void load_machine_code(ifstream &f, unsigned mem[]) {
    regex machine_code_re("^ram\\[(\\d+)\\] = 16'b(\\d+);.*$");
    size_t expectedaddr = 0;
    string line;
    while (getline(f, line)) {
        smatch sm;
        if (!regex_match(line, sm, machine_code_re)) {
            cerr << "Can't parse line: " << line << endl;
            exit(1);
        }
        size_t addr = stoi(sm[1], nullptr, 10);
        unsigned instr = stoi(sm[2], nullptr, 2);
        if (addr != expectedaddr) {
            cerr << "Memory addresses encountered out of sequence: " << addr << endl;
            exit(1);
        }
        if (addr >= MEM_SIZE) {
            cerr << "Program too big for memory" << endl;
            exit(1);
        }
        expectedaddr ++;
        mem[addr] = instr;
    }
}

/*
    Prints the current state of the simulator, including
    the current program counter, the current register values,
    and the first memquantity elements of memory.

    @param pc The final value of the program counter
    @param regs Final value of all registers
    @param memory Final value of memory
    @param memquantity How many words of memory to dump
*/

void print_state(unsigned pc, uint16_t regs[], unsigned memory[], size_t memquantity) {
    cout << setfill(' ');
    cout << "Final state:" << endl;
    cout << "\tpc=" <<setw(5)<< pc << endl;

    for (size_t reg=0; reg<NUM_REGS; reg++)
        cout << "\t$" << reg << "="<<setw(5)<<regs[reg]<<endl;

    cout << setfill('0');
    bool cr = false;
    for (size_t count=0; count<memquantity; count++) {
        cout << hex << setw(4) << memory[count] << " ";
        cr = true;
        if (count % 8 == 7) {
            cout << endl;
            cr = false;
        }
    }
    if (cr)
        cout << endl;
}

/* Convert the 3 LSB into an E20 Operator
 * @param code The machine code given
*/

int op_find(unsigned code) {
    // Sets immmediate to last 7 bits
    imm = code & 0b1111111;

    // Checks for negative number and 1 Complement it if it is 
    if (imm & 0b1000000) {
        imm = imm | 0b1111111110000000;
    }

    // Check for a correct opcode input, return -1 inc otherwise
    int op_code = -1;

    // takes 3 least signifigant bits and figures out which opcode is being run.
    switch ((code & 0b1110000000000000) >> 13) {
    case (0): 
        switch (code & 0b1111) { 
	// ADD
        case (0): 
            op_code = 0; 
            break;
	// SUB
        case (1): 
            op_code = 1;
            break;
	// OR
        case (2): 
            op_code = 2; 
            break;
	// AND
        case (3): 
            op_code = 3; 
            break;
	// SLT
        case (4): 
            op_code = 4; 
            break;
	// JR
        case (8): 
            op_code = 5; 
            break;
        }
        regC = ((code & 0b1110000) >> 4);
        break;
    // SLTI
    case (7):  
        op_code = 6; 
        break;
    // LW
    case (4): 
        op_code = 7; 
        break;
    // SW
    case (5): 
        op_code = 8; 
        break;
    // JEQ
    case (6): 
        op_code = 9; 
        break;
    // ADDI
    case (1): 
        op_code = 10; 
        break;
    // These two ops use least 13 bits as imm
    // J
    case (2): 
        op_code = 11; 
        imm = code & 0b1111111111111;
        if(imm == (pc & 0b1111111111111)){ 
            halt = true;
        }
        break;
    // JAL
    case (3): 
        op_code = 12; 
        imm = code & 0b1111111111111;
        break;
    }

    regB = ((code & 0b1110000000) >> 7); 
    regA = ((code & 0b1110000000000) >> 10);
    return op_code;
}

/* Executes E20 operator given converter op_code from op_find
 * @param op_code The converted operator code from op_find
 * @return program counter increment
*/

int run_op(int op_code) {
    int increment = 1;
    unsigned memory_address = (regs[regA] + imm) & 0b1111111111111; // Sets memory_address as the regA + imm but only last 13 bits 
    switch (op_code) {
    // ADD
    case (0): // If op_code is add
        if (regC != 0) {
            regs[regC] = regs[regA] + regs[regB];
        }
        break;
    // SUB
    case (1): 
        if (regC != 0) {
            regs[regC] = regs[regA] - regs[regB];
        }
        break;
    // OR
    case (2): 
        if (regC != 0) {
            regs[regC] = regs[regA] | regs[regB];
        }
        break;
    // AND
    case (3): 
        if (regC != 0) {
            regs[regC] = regs[regA] & regs[regB];
        }
        break;
    // SLT
    case (4): 
        if (regC != 0) {
            regs[regC] = regs[regA] < regs[regB];
        }
        break;
    //JR
    case (5): 
        pc = regs[regA];
        increment -= 1;
        break;
    // SLTI
    case (6): 
        if (regB != 0) {
            regs[regB] = regs[regA] < imm;
        }
        break;
    // LW -- here
    case (7): 
        if (regB != 0) {
            regs[regB] = mem[memory_address];
        }
        break;
    // SW -- here
    case (8): 
        mem[memory_address] = regs[regB];
        break;
    // JEQ
    case (9): 
        if (regs[regA] == regs[regB]) {
            increment = imm + 1;
        }
        break;
    // ADDI
    case (10): 
        if (regB != 0) {
            regs[regB] = regs[regA] + imm;
        }
        break;
    // J
    case (11): 
        pc = imm;
        increment -= 1;
        break;
    // JAL
    case (12): 
        regs[7] = pc + 1;
        pc = imm;
        increment -= 1;
        break;
    }
    return increment;
}


/* E20 Simulator Driver Function
 * @params None
*/

void e20() {
    int add, op, inc;
    unsigned machine_code;

    while (!halt) {
	// initialize address and machine code
        add = pc & 0b1111111111111;
	machine_code = mem[add];

	// get operation code
        op = op_find(machine_code);     

	// run operation and increment program counter
        inc = run_op(op);
        pc += inc;
    }
}

// ----------------------------------------------------

/*
    Prints out the correctly-formatted configuration of a cache.

    @param cache_name The name of the cache. "L1" or "L2"

    @param size The total size of the cache, measured in memory cells.
        Excludes metadata

    @param assoc The associativity of the cache. One of [1,2,4,8,16]

    @param blocksize The blocksize of the cache. One of [1,2,4,8,16,32,64])

    @param num_rows The number of rows in the given cache.
*/
void print_cache_config(const string &cache_name, int size, int assoc, int blocksize, int num_rows) {
    cout << "Cache " << cache_name << " has size " << size <<
        ", associativity " << assoc << ", blocksize " << blocksize <<
        ", rows " << num_rows << endl;
}

/*
    Prints out a correctly-formatted log entry.

    @param cache_name The name of the cache where the event
        occurred. "L1" or "L2"

    @param status The kind of cache event. "SW", "HIT", or
        "MISS"

    @param pc The program counter of the memory
        access instruction

    @param addr The memory address being accessed.

    @param row The cache row or set number where the data
        is stored.
*/
void print_log_entry(const string &cache_name, const string &status, int pc, int addr, int row) {
    cout << left << setw(8) << cache_name + " " + status <<  right <<
        " pc:" << setw(5) << pc <<
        "\taddr:" << setw(5) << addr <<
        "\trow:" << setw(4) << row << endl;
}

/**
    Main function
    Takes command-line args as documented below
*/
int main(int argc, char *argv[]) {
    /*
        Parse the command-line arguments
    */
    char *filename = nullptr;
    bool do_help = false;
    bool arg_error = false;
    string cache_config;
    for (int i=1; i<argc; i++) {
        string arg(argv[i]);
        if (arg.rfind("-",0)==0) {
            if (arg== "-h" || arg == "--help")
                do_help = true;
            else if (arg=="--cache") {
                i++;
                if (i>=argc)
                    arg_error = true;
                else
                    cache_config = argv[i];
            }
            else
                arg_error = true;
        } else {
            if (filename == nullptr)
                filename = argv[i];
            else
                arg_error = true;
        }
    }
    /* Display error message if appropriate */
    if (arg_error || do_help || filename == nullptr) {
        cerr << "usage " << argv[0] << " [-h] [--cache CACHE] filename" << endl << endl;
        cerr << "Simulate E20 cache" << endl << endl;
        cerr << "positional arguments:" << endl;
        cerr << "  filename    The file containing machine code, typically with .bin suffix" << endl<<endl;
        cerr << "optional arguments:"<<endl;
        cerr << "  -h, --help  show this help message and exit"<<endl;
        cerr << "  --cache CACHE  Cache configuration: size,associativity,blocksize (for one"<<endl;
        cerr << "                 cache) or"<<endl;
        cerr << "                 size,associativity,blocksize,size,associativity,blocksize"<<endl;
        cerr << "                 (for two caches)"<<endl;
        return 1;
    }

    // Init file stream
    ifstream f(filename);

    /* parse cache config */
    if (cache_config.size() > 0) {
        vector<int> parts;
        size_t pos;
        size_t lastpos = 0;
        while ((pos = cache_config.find(",", lastpos)) != string::npos) {
            parts.push_back(stoi(cache_config.substr(lastpos,pos)));
            lastpos = pos + 1;
        }
        parts.push_back(stoi(cache_config.substr(lastpos)));
        if (parts.size() == 3) {
            int L1size = parts[0];
            int L1assoc = parts[1];
            int L1blocksize = parts[2];
            // TODO: execute E20 program and simulate one cache here
            load_machine_code(f, mem);	 
            e20();
            //print_state(pc, regs, mem, 128);
        } else if (parts.size() == 6) {
            int L1size = parts[0];
            int L1assoc = parts[1];
            int L1blocksize = parts[2];
            int L2size = parts[3];
            int L2assoc = parts[4];
            int L2blocksize = parts[5];
            // TODO: execute E20 program and simulate two caches here
            load_machine_code(f, mem);
            e20();
            //print_state(pc, regs, mem, 128);
        } else {
            cerr << "Invalid cache config"  << endl;
            return 1;
        }
    }

    return 0;
}
//ra0Eequ6ucie6Jei0koh6phishohm9
