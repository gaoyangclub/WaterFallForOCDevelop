//
//  CardInfoManager.m
//  WaterFallForOC
//
//  Created by 高扬 on 16/9/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CardInfoManager.h"

@implementation ImageVo

-(instancetype)init:(NSString*)url andName:(NSString*)name andDes:(NSString*)des{
    self = [super init];
    if (self) {
        self.imageUrl = url;
        self.name = name;
        self.cellHeight = 200;
        self.describe = des;
    }
    return self;
}

@end

@implementation CardInfoManager

+(NSMutableArray*)getAllCardInfo{
    return [[NSMutableArray alloc]initWithObjects:
            [[ImageVo alloc]init:@"blueParrot" andName:@"Parrot1" andDes:@"he blue-headed parrot, also known as the blue-headed pionus (Pionus menstruus) is a medium large parrot. It is about 27 cm long and they are mainly green with a blue head and neck, and red under tail feathers. It is a resident bird in tropical and subtropical South America and southern Central America, from Costa Rica, Venezuela and Trinidad south to Bolivia and Brazil."],
            [[ImageVo alloc]init:@"harpy" andName:@"Harpy Eagle" andDes:@"The harpy eagle (Harpia harpyja) is a Neotropical species of eagle. It is sometimes known as the American harpy eagle to distinguish it from the Papuan eagle which is sometimes known as the New Guinea harpy eagle or Papuan harpy eagle. It is the largest and most powerful raptor found in the Americas, and among the largest extant species of eagles in the world."],
            [[ImageVo alloc]init:@"macaw" andName:@"Macaw" andDes:@"Macaws are long-tailed, often colourful New World parrots. Of the many different Psittacidae (true parrots) genera, six are classified as macaws: Ara, Anodorhynchus, Cyanopsitta, Primolius, Orthopsittaca, and Diopsittaca. Previously, the members of the genus Primolius were placed in Propyrrhura, but the former is correct in accordance with ICZN rules."],
            [[ImageVo alloc]init:@"lovebird" andName:@"Lovebird" andDes:@"A lovebird is one of nine species of the genus Agapornis (Greek: αγάπη agape 'love'; όρνις ornis 'bird'). They are a social and affectionate small parrot. Eight species are native to the African continent, and the grey-headed lovebird is native to Madagascar. Their name stems from the parrots' strong, monogamous pair bonding and the long periods which paired birds spend sitting together."],
            [[ImageVo alloc]init:@"blueMorpho" andName:@"Blue Morpho" andDes:@"The Menelaus Blue Morpho (Morpho menelaus) is an iridescent tropical butterfly of Central and South America. It has a wing span of 15 cm (5.9 in). The adult drinks juice from rotten fruit with its long proboscis, which is like a sucking tube. The adult males have brighter colours than the females. Morpho menelaus is a very large butterfly, with a wingspan of approximately 138 mm."],
            [[ImageVo alloc]init:@"brownPeacock" andName:@"Brown Peacock" andDes:@"The brown peacock or scarlet peacock (Anartia amathea) is a species of nymphalid butterfly, found primarily in South America. The type locality is probably Suriname, and the species is found from Panama to Argentina; Grenada, Barbados, Antigua. It is reported as common in Argentina, Paraguay, Uruguay, the Brazilian highlands, the eastern Amazon, the Guianas, Venezuela, and Panama, ..."],
            [[ImageVo alloc]init:@"rock" andName:@"Cock of the Rock" andDes:@"The cock-of-the-rock, which compose the genus Rupicola, are South American cotingid birds. The Andean cock-of-the-rock is the national bird of Peru. They are found in tropical and subtropical rainforests close to rocky areas, where they build their nests. The males are magnificent birds, not only because of their bright orange or red colors, but also because of their very prominent..."],
            [[ImageVo alloc]init:@"atoo" andName:@"Cockatoo" andDes:@"A cockatoo is any of the 21 species belonging to the bird family Cacatuidae, the only family in the superfamily Cacatuoidea. Along with the Psittacoidea (true parrots) and the Strigopoidea (large New Zealand parrots), they make up the order Psittaciformes (parrots). The family has a mainly Australasian distribution, ranging from the Philippines and the eastern Indonesian islands of Wallacea..."],
            [[ImageVo alloc]init:@"pygmy" andName:@"Pygmy Marmoset" andDes:@"The pygmy marmoset (Cebuella pygmaea) is a small New World monkey native to rainforests of the western Amazon Basin in South America. It is notable for being the smallest monkey and one of the smallest primates in the world at just over 100 grams (3.5 oz) (Madame Berthe's mouse lemur is smaller). It is generally found in evergreen and river edge forests and is a gum-feeding specialist."],
            [[ImageVo alloc]init:@"toucan" andName:@"Toucan" andDes:@"Toucans are members of the family Ramphastidae of near passerine birds from the Neotropics. The Ramphastidae family is most closely related to the American barbets. They are brightly marked and have large, often colorful bills. The family includes five genera and about forty different species. The name of this bird group is derived from the Tupi word tukana, via Portuguese."],
            [[ImageVo alloc]init:@"sloth" andName:@"Sloth" andDes:@"Sloths (/ˈsloʊθ/ sloh-th, /ˈslɒθ/ slo-th) are medium-sized mammals belonging to the families Megalonychidae (two-toed sloth) and Bradypodidae (three-toed sloth), classified into six species. They are part of the order Pilosa and are therefore related to anteaters, which sport a similar set of specialized claws. Extant sloths are arboreal (tree-dwelling) residents of the jungles of Central..."],
            [[ImageVo alloc]init:@"ant" andName:@"Leafcutter Ant" andDes:@"Leafcutter ants, a non-generic name, are any of 47 species of leaf-chewing ants belonging to the two genera Atta and Acromyrmex. These species of tropical, fungus-growing ants are all endemic to South and Central America, Mexico, and parts of the southern United States. Leafcutter ants \"cut and process fresh vegetation (leaves, flowers, and grasses) to serve as the nutritional substrate for..."],
            [[ImageVo alloc]init:@"margay" andName:@"Margay" andDes:@"The margay (Leopardus wiedii) is a small cat native to Central and South America that is listed as \"Near Threatened\" by the IUCN since 2008 because remaining populations are thought to be declining due to loss of habitat following conversion of forests. In his first description, Schinz named the margay Felis wiedii in honour of Prince Maximilian of Wied-Neuwied who collected..."],
            [[ImageVo alloc]init:@"treeFrog" andName:@"Tree Frog" andDes:@"A tree frog is any frog that spends a major portion of its lifespan in trees, known as an arboreal state. Several lineages of frogs among the Neobatrachia have given rise to tree frogs, even though they are not closely related to each other. Many millions of years of convergent evolution have resulted in almost identical morphology and ecologies. In fact, they are so similar as regards their..."],
            [[ImageVo alloc]init:@"spiderMonkey" andName:@"Spider Monkey" andDes:@"Spider monkeys of the genus Ateles are New World monkeys in the subfamily Atelinae, family Atelidae. Like other atelines, they are found in tropical forests of Central and South America, from southern Mexico to Brazil. The genus contains seven species, all of which are under threat; the black-headed spider monkey, and brown spider monkey are critically endangered."],
            [[ImageVo alloc]init:@"anteater" andName:@"Anteater" andDes:@"Anteater is a common name for the four mammal species of the suborder Vermilingua (meaning \"worm tongue\") commonly known for eating ants and termites. The individual species have other names in English and other languages. Together with the sloths, they compose the order Pilosa. The name \"anteater\" is also colloquially applied to the unrelated aardvark..."],
            [[ImageVo alloc]init:@"jag" andName:@"Jaguar" andDes:@"The jaguar (/ˈdʒæɡwɑr/ or UK /ˈdʒæɡjuː.ər/; Brazilian Portuguese: [ʒɐˈɡwaʁ], Spanish: [xaˈɣwar]), Panthera onca, is a big cat, a feline in the Panthera genus, and is the only Panthera species found in the Americas. The jaguar is the third-largest feline after the tiger and the lion, and the largest in the Western Hemisphere. The jaguar's present range extends from Southwestern United States and Mexico across..."],
            [[ImageVo alloc]init:@"caiman" andName:@"Caiman" andDes:@"Caimans are alligatorid crocodylians within Caimaninae. The group is one of two primary lineages within Alligatoridae, the other being alligators. Caimans inhabit Central and South America. They are relatively small crocodylians, with the smallest being Cuvier's dwarf caiman (Paleosuchus palpebrosus), which grows to 1 m (3 ft) long, and the largest being the black..."],
            
    nil];
}

@end
