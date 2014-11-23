#define false   0
#define true    1   
#define bool    _Bool

extern int printf(const char *format, ...);
extern int strcmp(const char *s1, const char *s2);
extern void GC_init();
extern void* GC_malloc(unsigned long size);
extern void* GC_realloc(void* ptr,unsigned long size);

typedef enum { STRING, NUMBER, BOOLEAN, LIST, MAP, NULL, VOID } BuiltinType;
typedef struct List {
    int size;
    int capacity;
    struct Object* items;
} List;
typedef struct Object {
    BuiltinType type;
    union Value {
        bool boolean;
        double number;
        const char* string;
        struct List* list;
    } value;
} Object;


void printList(List* list) {
    printf("[");
    for (int i = 0; i < list->size; i++) {
        
        if (i > 0) printf(", ");
        switch(list->items[i].type) {
            case STRING: printf("\"%s\"", list->items[i].value.string); break;
            case NUMBER: printf("%g", list->items[i].value.number); break;
            case BOOLEAN: printf(list->items[i].value.boolean == true ? "true" : "false"); break;
            case NULL: printf("null"); break;
            case LIST: printList(list->items[i].value.list); break;
            default:
            break;
        }
    }
    printf("]");
}

bool listsEqual(List* list1, List* list2) {
    if (list1->size != list2->size) {
        return false;
    }
    for (int i = 0; i < list1->size; i++) {
        if (list1->items[i].type != list2->items[i].type) {
            return false;
        }
        switch (list1->items[i].type) {
            case STRING: 
                if (strcmp(list1->items[i].value.string, list2->items[i].value.string) != 0) {
                    return false;
                }
                break;
            case NUMBER:  
                if (list1->items[i].value.number - list2->items[i].value.number != 0.0) {
                    return false;
                }
                break;
            case BOOLEAN:  
                if (list1->items[i].value.boolean != list2->items[i].value.boolean) {
                    return false;
                }
                break;
            case LIST: 
                if(listsEqual(list1->items[i].value.list, list2->items[i].value.list) != true) {
                    return false;
                } 
                break;
            case MAP:
                //TODO
                break;
            case NULL: 
            case VOID:
                break;
            default:
                return false;
            break;
        }
    }
    return true;
}

bool isEmpty(List* list) {
    return list->size == 0;
}

List* addListToList(List* list, List* add);

void listResize(List* list, int newsize) {
    if (list->capacity < (list->size + newsize)){
        list->items = GC_realloc( list->items, sizeof(Object) * (newsize + 10) );
        list->capacity = newsize + 10;
    }
    list->size = newsize;
}


List* initList(int size) {
    List* list = (List *) GC_malloc(sizeof(List));
    list->items = (Object *) GC_malloc(sizeof(Object) * (size + 10));
    list->size = 0;
    list->capacity = size + 10;
    return list;
}

List* listCopy(List* from) {
    List* to = initList(from->size);
    addListToList(to, from);
    return to;
}

List* addStringToList(List* list, const char* string) {
    int size = list->size;
    listResize(list, size + 1);
    list->items[size].type = STRING;
    list->items[size].value.string = string;
    return list;
}

List* addNumberToList(List* list, double number) {
    int size = list->size;
    listResize(list, size + 1);
    list->items[size].type = NUMBER;
    list->items[size].value.number = number;
    return list;
}

List* addBooleanToList(List* list, bool boolean) {
    int size = list->size;
    listResize(list, size + 1);
    list->items[size].type = BOOLEAN;
    list->items[size].value.boolean = boolean;   
    return list;
}

List* addNullToList(List* list) {
    int size = list->size;
    listResize(list, size + 1);
    list->items[size].type = NULL;
    return list;
}

List* addListToList(List* list, List* add) {
    int size = list->size;
    for (int i = size, j = 0; i < size+add->size; i++, j++) {
        switch (add->items[j].type) {
            case STRING: addStringToList(list, add->items[j].value.string); break;
            case NUMBER: addNumberToList(list, add->items[j].value.number); break;
            case BOOLEAN: addBooleanToList(list, add->items[j].value.boolean); break;
            case LIST: 
                listResize(list, i + 1);
                list->items[i].type = LIST;
                List* oldList = add->items[j].value.list;
                List* newList = initList(oldList->size);
                list->items[i].value.list = addListToList(newList, oldList);
                break;
            default: case NULL: addNullToList(list); break;
        }
    }
    return list;
}

int main2(void) {
    
    GC_init();
    List* a = initList(5);
    List* b = initList(4);

    Object *items = (Object *) GC_malloc(sizeof(Object) * 100);

    
    items[0].type = BOOLEAN;
    items[0].value.boolean = true;
    items[1].type = STRING;
    items[1].value.string = "hello world";
    items[2].type = NUMBER;
    items[2].value.number = 123.2;
    items[3].type = NULL;
    items[4].type = LIST;
    items[4].value.list = b;
    
    a->size = 5;
    a->capacity = 5;
    a->items = items;

    // b->size = 4;
    // b->capacity = 4;
    // b->items = items;
    

    printList(a);
    printf("\n\n");
    printList(listCopy(a));
    printf("\n");
    
    return 0;
}



