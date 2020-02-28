def find_item_by_name_in_collection(name, collection)
    index = 0
      while index < collection.count do
        if collection[index][:item] === name
            # p collection[index]
        return collection[index]
        else
        index += 1
    # p "it's not there"
      end
end
  
  
end


def consolidate_cart(cart)
consolcart = []
index=0
while index < cart.length do
  name = ""
  newhash = {}
  name_check = cart[index][:item]
    if find_item_by_name_in_collection(name_check, consolcart)
        item = find_item_by_name_in_collection(name_check, consolcart)
        itemcount = consolcart.index(item)
        consolcart[itemcount][:count] += 1
        # in, updated count
      else 
        newhash = { 
        :item => cart[index][:item],
        :price => cart[index][:price],
        :clearance => cart[index][:clearance],
        :count => 1,
              }
        consolcart << newhash
        # not in, adds new hash to array
    end
    index += 1
  end
  # puts "final cart is #{consolcart}"
  return consolcart
end

            


def apply_coupons(cart, coupons)
index = 0
  while index < coupons.count do
    cart_item = find_item_by_name_in_collection(coupons[index][:item], cart)
    new_coupon_name = "#{coupons[index][:item]} W/COUPON"
    cart_item_coupon = find_item_by_name_in_collection(new_coupon_name, cart)
    
    if cart_item && cart_item[:count] >= coupons[index][:num] 
      
        if !cart_item_coupon
                     cart_item_coupon = {
             :item => "#{coupons[index][:item]} W/COUPON",
              :price => (coupons[index][:cost] / coupons[index][:num]).round(2),
              :clearance => cart_item[:clearance],
              :count => coupons[index][:num],
           }
           cart << cart_item_coupon
           cart_item[:count] -= coupons[index][:num]
        else
          cart_item_coupon[:count] += coupons[index][:num]
          cart_item[:count] -= coupons[index][:num]
        end
      end
    index += 1 
  end  
cart  
end

def apply_clearance(cart)
    index = 0
  
    array = []
    while index < cart.count do
      
        if cart[index][:clearance]
   #   puts "should reduce this"
      toreduce = cart[index]
      toreduce[:price] = (toreduce[:price]*0.80).round(2)
      array << toreduce
      else
        array << cart[index]
      end
        index+=1
  end
array
end

def checkout(cart, coupons)

concart = consolidate_cart(cart)
coupcart = apply_coupons(concart, coupons)
clearcart = apply_clearance(coupcart)

index=0
subtotal = 0
  while index < clearcart.count do
    itemprice = clearcart[index][:price] * clearcart[index][:count]
    subtotal += itemprice
    index += 1
  end
if subtotal > 100
  total = (subtotal * 0.90).round(2)
else
  total = subtotal 

end
return total
end


