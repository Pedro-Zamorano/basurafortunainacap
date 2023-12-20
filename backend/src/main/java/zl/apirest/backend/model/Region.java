package zl.apirest.backend.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "regions")
public class Region extends PkEntityBase {

    @Column(name = "region_name", nullable = false)
    private String regionName;

    @Column(name = "code", nullable = false)
    private int code;

}
